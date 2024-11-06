<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Objeto implícito: request
    // Leer el parámetro "nombre" desde la solicitud
    String nombre = request.getParameter("nombre");

    // Objeto implícito: session
    // Obtener el contador de visitas en la sesión del usuario
    Integer visitas = (Integer) session.getAttribute("visitas");

    if (visitas == null) {
        visitas = 1; // Primera visita de la sesión
    } else {
        visitas += 1; // Incrementar el contador de visitas
    }
    session.setAttribute("visitas", visitas); // Guardar el contador actualizado en la sesión

    // Objeto implícito: application
    // Obtener y actualizar el contador de visitas global
    Integer contadorGlobal = (Integer) application.getAttribute("contadorGlobal");
    if (contadorGlobal == null) {
        contadorGlobal = 1;
    } else {
        contadorGlobal += 1;
    }
    application.setAttribute("contadorGlobal", contadorGlobal);

    // Objeto implícito: response
    // Configurar el tipo de contenido de la respuesta
    response.setContentType("text/html;charset=UTF-8");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Ejemplo de Objetos Implícitos en JSP</title>
    </head>
    <body>
        <h2>Ejemplo de Objetos Implícitos en JSP</h2>

        <!-- Formulario para recibir el nombre del usuario -->
        <form method="POST">
            <label for="nombre">Ingrese su nombre:</label>
            <input type="text" id="nombre" name="nombre" required>
            <input type="submit" value="Enviar">
        </form>

        <%
            // Objeto implícito: out
            // Escribir un mensaje de bienvenida al usuario
            if (nombre != null && !nombre.isEmpty()) {
                out.println("<p>Bienvenido, " + nombre + "!</p>");
            } else {
                out.println("<p>Bienvenido, visitante anónimo!</p>");
            }
        %>

        <h3>Información de la Sesión</h3>
        <p>Número de visitas en esta sesión: <%= visitas%></p>

        <h3>Información de la Aplicación</h3>
        <p>Contador global de visitas a la página: <%= contadorGlobal%></p>

        <h3>Uso de `request` para obtener detalles de la solicitud:</h3>
        <p>Dirección IP del cliente: <%= request.getRemoteAddr()%></p>
        <p>Método de la solicitud: <%= request.getMethod()%></p>

        <h3>Información de la página</h3>
        <p>Clase de la página JSP actual: <%= page.getClass().getName()%></p>

        <!-- Usar JSTL para mostrar datos almacenados en la sesión -->
        <h3>Uso de JSTL para mostrar los datos</h3>
        <c:if test="${not empty sessionScope.visitas}">
            <p>Número de visitas usando JSTL: ${sessionScope.visitas}</p>
        </c:if>

    </body>
</html>
