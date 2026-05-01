# University Management System (ASP.NET Web Forms + SQL + AI Assistant)

This repository now contains a starter implementation of a **University Management System** using:

- **C# ASP.NET Web Forms**
- **SQL Server database**
- **ADO.NET (no heavy ORM, easy to learn and extend)**
- A first version of an **AI assistant service** that reads university data and answers questions

## Project Structure

```text
UniversityManagementSystem/
  App_Code/
    AiAssistantService.cs
    Models.cs
    UniversityRepository.cs
  Database/
    ums_schema.sql
  AiAssistant.aspx
  Courses.aspx
  Default.aspx
  Enrollments.aspx
  Students.aspx
  Web.config
```

## Features Included

- Dashboard with totals (students, courses, enrollments)
- Manage students
- Manage courses
- Manage enrollments
- AI Assistant page that:
  - takes a user question
  - builds context from the university database
  - responds with either:
    - mock/local answer (default), or
    - real LLM response via OpenAI-compatible endpoint
  - logs every AI conversation to SQL

## 1) SQL Database Setup

Run the SQL script:

`UniversityManagementSystem/Database/ums_schema.sql`

This script creates tables and sample data:

- Departments
- Students
- Instructors
- Courses
- Enrollments
- AiConversationLogs

## 2) Configure Connection String

Open `UniversityManagementSystem/Web.config` and update:

```xml
<connectionStrings>
  <add name="UmsDb"
       connectionString="Server=.;Database=UmsDb;Trusted_Connection=True;"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

## 3) Configure AI Provider (Optional)

By default, AI runs in **Mock** mode.

To use a real model, update `appSettings` in `Web.config`:

```xml
<add key="Ai:Provider" value="OpenAICompatible" />
<add key="Ai:Endpoint" value="https://api.openai.com/v1/chat/completions" />
<add key="Ai:ApiKey" value="YOUR_API_KEY" />
<add key="Ai:Model" value="gpt-4o-mini" />
```

## 4) Run the Web Forms App

Open the `UniversityManagementSystem` folder in Visual Studio (as an ASP.NET Web Site/Web Forms app), then run with IIS Express.

Pages:

- `/Default.aspx`
- `/Students.aspx`
- `/Courses.aspx`
- `/Enrollments.aspx`
- `/AiAssistant.aspx`

## Suggested Next Step for “AI Agent that Learns from University DB”

The current assistant already uses live DB context. Next step is to evolve this into a stronger learning agent:

1. Add a `KnowledgeChunks` table with curated text summaries from policies, syllabus, FAQs.
2. Add embedding generation (OpenAI or Azure OpenAI) and store vectors.
3. Implement RAG search:
   - question -> embedding
   - top-K similar chunks + SQL facts
   - feed to model
4. Add role-based answer filtering (student/instructor/admin).
5. Add feedback loop table (`AiFeedback`) to improve prompts and retrieval quality.

This gives a practical “learning from university data” pipeline while keeping data governance under your control.
