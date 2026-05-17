using System;
using System.Configuration;
using System.Data.SqlClient;

public static class DbHelper
{
    public static string ConnectionString
    {
        get { return ConfigurationManager.ConnectionStrings["UmsDb"].ConnectionString; }
    }

    public static SqlConnection GetConnection()
    {
        return new SqlConnection(ConnectionString);
    }

    public static int ExecuteScalarInt(SqlConnection connection, string sql)
    {
        using (var command = new SqlCommand(sql, connection))
        {
            var result = command.ExecuteScalar();
            return result != null ? Convert.ToInt32(result) : 0;
        }
    }
}
