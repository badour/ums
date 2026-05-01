using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;

public class AiAssistantService
{
    private readonly UniversityRepository _repository;
    private readonly string _provider;
    private readonly string _endpoint;
    private readonly string _apiKey;
    private readonly string _model;

    public AiAssistantService()
        : this(new UniversityRepository())
    {
    }

    public AiAssistantService(UniversityRepository repository)
    {
        _repository = repository;
        _provider = ConfigurationManager.AppSettings["Ai:Provider"] ?? "Mock";
        _endpoint = ConfigurationManager.AppSettings["Ai:Endpoint"] ?? string.Empty;
        _apiKey = ConfigurationManager.AppSettings["Ai:ApiKey"] ?? string.Empty;
        _model = ConfigurationManager.AppSettings["Ai:Model"] ?? "gpt-4o-mini";
    }

    public string Ask(string userQuestion, string askedBy = "anonymous")
    {
        if (string.IsNullOrWhiteSpace(userQuestion))
        {
            return "Please ask a valid question.";
        }

        var students = _repository.GetAllStudents();
        var courses = _repository.GetAllCourses();
        var enrollments = _repository.GetAllEnrollments();

        var contextBuilder = new StringBuilder();
        contextBuilder.AppendLine("University facts:");
        contextBuilder.AppendLine("Total students: " + students.Count);
        contextBuilder.AppendLine("Total courses: " + courses.Count);
        contextBuilder.AppendLine("Total enrollments: " + enrollments.Count);
        contextBuilder.AppendLine();
        contextBuilder.AppendLine("Students (top 5):");
        for (int i = 0; i < Math.Min(5, students.Count); i++)
        {
            var s = students[i];
            contextBuilder.AppendLine("- " + s.FullName + " (" + s.StudentNumber + ")");
        }

        contextBuilder.AppendLine("Courses (top 5):");
        for (int i = 0; i < Math.Min(5, courses.Count); i++)
        {
            var c = courses[i];
            contextBuilder.AppendLine("- " + c.CourseCode + ": " + c.CourseTitle + " (" + c.CreditHours + " credits)");
        }

        var context = contextBuilder.ToString();
        string answer;

        if (_provider.Equals("OpenAICompatible", StringComparison.OrdinalIgnoreCase)
            && !string.IsNullOrWhiteSpace(_endpoint)
            && !string.IsNullOrWhiteSpace(_apiKey))
        {
            answer = AskOpenAiCompatible(userQuestion, context);
        }
        else
        {
            answer = AskMock(userQuestion, students.Count, courses.Count, enrollments.Count);
        }

        _repository.InsertAiConversationLog(askedBy, userQuestion, answer, _provider);
        return answer;
    }

    private string AskMock(string question, int studentCount, int courseCount, int enrollmentCount)
    {
        return "Mock AI response:\n\n"
            + "You asked: " + question + "\n"
            + "Current snapshot -> Students: " + studentCount
            + ", Courses: " + courseCount
            + ", Enrollments: " + enrollmentCount + ".\n"
            + "To get smarter answers, configure Ai:Provider=OpenAICompatible in Web.config.";
    }

    private string AskOpenAiCompatible(string question, string context)
    {
        var serializer = new JavaScriptSerializer();

        var body = new Dictionary<string, object>
        {
            { "model", _model },
            {
                "messages", new[]
                {
                    new Dictionary<string, string>
                    {
                        { "role", "system" },
                        { "content", "You are a university assistant. Use provided university facts first. If unknown, say you don't have enough data." }
                    },
                    new Dictionary<string, string>
                    {
                        { "role", "user" },
                        { "content", "Question: " + question + "\n\nContext:\n" + context }
                    }
                }
            },
            { "temperature", 0.2 }
        };

        var jsonBody = serializer.Serialize(body);
        var request = (HttpWebRequest)WebRequest.Create(_endpoint);
        request.Method = "POST";
        request.ContentType = "application/json";
        request.Headers["Authorization"] = "Bearer " + _apiKey;

        var bytes = Encoding.UTF8.GetBytes(jsonBody);
        using (var stream = request.GetRequestStream())
        {
            stream.Write(bytes, 0, bytes.Length);
        }

        try
        {
            using (var response = (HttpWebResponse)request.GetResponse())
            using (var responseStream = response.GetResponseStream())
            using (var reader = new StreamReader(responseStream))
            {
                var responseText = reader.ReadToEnd();
                dynamic parsed = serializer.DeserializeObject(responseText);

                var choices = parsed["choices"] as object[];
                if (choices != null && choices.Length > 0)
                {
                    var first = choices[0] as Dictionary<string, object>;
                    if (first != null && first.ContainsKey("message"))
                    {
                        var message = first["message"] as Dictionary<string, object>;
                        if (message != null && message.ContainsKey("content"))
                        {
                            return Convert.ToString(message["content"]);
                        }
                    }
                }
            }
        }
        catch (WebException ex)
        {
            return "AI provider error: " + ex.Message + ". Falling back to mock insights is recommended.";
        }

        return "No response content from AI provider.";
    }
}
