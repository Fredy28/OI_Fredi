<%-- 
    Document   : asientos
    Created on : 05-nov-2024, 20:27:27
    Author     : fredi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Inicializar asientos disponibles en el ámbito de la aplicación si no existe
    List<Integer> asientosDisponibles = (List<Integer>) application.getAttribute("asientosDisponibles");
    if (asientosDisponibles == null) {
        asientosDisponibles = new ArrayList<>();
        for (int i = 1; i <= 30; i++) { // Suponemos 30 asientos
            asientosDisponibles.add(i);
        }
        application.setAttribute("asientosDisponibles", asientosDisponibles);
    }

    // Procesar la selección de asiento del usuario
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String edadStr = request.getParameter("edad");
    String asientoSeleccionadoStr = request.getParameter("asiento");

    if (nombre != null && apellido != null && edadStr != null && asientoSeleccionadoStr != null) {
        int edad = Integer.parseInt(edadStr);
        int asientoSeleccionado = Integer.parseInt(asientoSeleccionadoStr);

        if (asientosDisponibles.contains(asientoSeleccionado)) {
            asientosDisponibles.remove((Integer) asientoSeleccionado); // Eliminar asiento de la lista
            application.setAttribute("asientosDisponibles", asientosDisponibles);

            // Guardar los datos del usuario en la sesión
            session.setAttribute("nombre", nombre);
            session.setAttribute("apellido", apellido);
            session.setAttribute("edad", edad);
            session.setAttribute("asientoSeleccionado", asientoSeleccionado);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Selección de Asientos</title>
</head>
<body>
    <h2>Selección de Asientos</h2>

    <!-- Mostrar asientos disponibles -->
    <h3>Asientos Disponibles</h3>
    <ul>
        <c:forEach var="asiento" items="${asientosDisponibles}">
            <li>Asiento ${asiento}</li>
        </c:forEach>
    </ul>

    <!-- Formulario de selección de asiento -->
    <form method="POST">
        <h3>Ingrese sus datos</h3>
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br>

        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required><br>

        <label for="edad">Edad:</label>
        <input type="number" id="edad" name="edad" required><br>

        <label for="asiento">Seleccione un asiento:</label>
        <select id="asiento" name="asiento" required>
            <c:forEach var="asiento" items="${asientosDisponibles}">
                <option value="${asiento}">Asiento ${asiento}</option>
            </c:forEach>
        </select><br>

        <input type="submit" value="Reservar Asiento">
    </form>

    <!-- Mostrar confirmación de reserva -->
    <c:if test="${not empty sessionScope.asientoSeleccionado}">
        <h3>Reserva Confirmada</h3>
        <p>Nombre: ${sessionScope.nombre} ${sessionScope.apellido}</p>
        <p>Edad: ${sessionScope.edad}</p>
        <p>Asiento Reservado: Asiento ${sessionScope.asientoSeleccionado}</p>
    </c:if>
</body>
</html>
