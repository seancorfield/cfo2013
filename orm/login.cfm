<cfif structKeyExists( form, "submit" )>
  <cfif form.username is "admin" and form.password is "admin">
    <cflocation addtoken="false" url="post.cfm" />
  <cfelse>
    <cfset message = "Invalid username/password" />
  </cfif>
</cfif>
<html>
<head>
<title>ORM, NoSQL, and Vietnam - Login</title>
</head>
<body>
<cfoutput>
  <h1>Admin Login</h1>
  <cfif structKeyExists( variables, "message" )>
    <p>#message#</p>
  </cfif>
  <form method="post" action="login.cfm">
    <table>
      <tr><td>Username:</td>
        <td><input type="text" name="username" /></td></tr>
      <tr><td>Password:</td>
        <td><input type="password" name="password" /></td></tr>
      <tr><td>&nbsp;</td>
        <td><input type="submit" name="submit" value="Login" /></td></tr>
    </table>
  </form>
  <cfinclude template="footer.cfm"/>
</cfoutput>
</body>
</html>
