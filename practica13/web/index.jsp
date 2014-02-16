<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ClasesHospital.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acciones con Tabla Departamentos</title>
        <link rel="stylesheet" href="css/departamentos.css"/>
        <script language="javascript" type="text/javascript">
            function mostrarDatos(num, nom, loc)
            {
                document.form1.txtnum.value = num;
                document.form1.txtnom.value = nom;
                document.form1.txtloc.value = loc;
                var tr = document.getElementById("fila"+num);
                tr.style.backgroundColor="#ffecd0";
            }
            
            function seleccionarAccion(accion)
            {
                document.form1.txtaccion.value = accion;
                document.form1.submit();
            }
        </script>
    </head>
    <body>
        <form name="form1">
            <%
                String accion = request.getParameter("txtaccion");
                if(accion!=null)
                {%>
                    <input type="HIDDEN" name="txtaccion" value="<%=accion%>"/>
              <%}else{%>  
                    <input type="HIDDEN" name="txtaccion"/>
              <%}%>
            <table class="tabladept">
                <tr>
                    <th colspan="3">Departamentos</th>
                </tr>
                <tr>
                    <th>NUMERO</th>
                    <td colspan="2">
                        <input type="text" name="txtnum"/>
                    </td>
                </tr>
                <tr>
                    <th>NOMBRE</th>
                    <td colspan="2">
                        <input type="text" name="txtnom"/>
                    </td>
                </tr>
                <tr>
                    <th>LOCALIDAD</th>
                    <td colspan="2">
                        <input type="text" name="txtloc"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" value="Insertar" onclick="seleccionarAccion('insertar')"/>
                    </td>
                    <td>
                        <input type="button" value="Modificar" onclick="seleccionarAccion('modificar')"/>
                    </td>
                    <td>
                        <input type="button" value="Eliminar" onclick="seleccionarAccion('eliminar')"/>
                    </td>                    
                </tr>
            </table>
            <%
            DepartamentosHelper depthelper = new DepartamentosHelper();
            if (accion!=null)
            {
                int num = Integer.parseInt(request.getParameter("txtnum"));
                String nom = request.getParameter("txtnom");
                String loc = request.getParameter("txtloc");
                out.println("<table class='tablaacc'><td>");
                if (accion.equals("insertar"))
                {
                    depthelper.insertarDepartamento(num, nom, loc);    
                    out.println("<h4>Departamento insertado correctamente</h4>");
                }else if (accion.equals("modificar"))
                {
                    depthelper.modificarDepartamento(num, nom, loc);
                    out.println("<h4>Departamento modificado correctamente</h4>");
                }else if (accion.equals("eliminar"))
                {
                    depthelper.eliminarDepartamento(num);
                    out.println("<h4>Departamento eliminado correctamente</h4>");
                }
                out.println("</td></table>");
            }
           
            List listadept = depthelper.getDepartamentos();
            out.print("<table class='tablapel'>");
            out.print("<tr><th></th><th>NUMERO</th><th>NOMBRE</th><th>LOCALIDAD</th></tr>");
            for (int i = 0; i < listadept.size(); i++) {
                Dept d = (Dept) listadept.get(i);
                int num = d.getDeptNo();
                String nom = d.getDnombre();
                String loc = d.getLoc();
                out.print("<tr id='fila" + num + "'>");
out.print("<td><a href='javascript:mostrarDatos(" + num + ",\"" + nom + "\",\"" + loc + "\")'>Seleccionar</a></td>");
                out.print("<td>" + num +"</td>");
                out.print("<td>" + nom +"</td>");
                out.print("<td>" + loc +"</td>");
                out.print("</tr>");
            }
            out.print("</table>");
        %>            
        </form></body></html>
