package main.java.com.example.aplicacionweblab;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;

@WebServlet("/ServletInsertar")
public class ServletInsertar extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String tipoTrabajador = request.getParameter("tipo-trabajador");
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String cedula = request.getParameter("cedula");
        String departamento = request.getParameter("departamento");
        String salario = request.getParameter("salario");
        String deducciones = request.getParameter("deducciones");
        String horasTrabajadas = request.getParameter("horas-trabajadas");
        String tarifaHoraria = request.getParameter("tarifa-horaria");

        // Crear una cadena con los datos
        String datosTrabajador = tipoTrabajador + "," + nombre + "," + direccion + "," + telefono + "," + cedula + "," + departamento;

        if (tipoTrabajador.equals("empleado")) {
            datosTrabajador += "," + salario + "," + deducciones;
        } else if (tipoTrabajador.equals("consultor")) {
            datosTrabajador += "," + horasTrabajadas + "," + tarifaHoraria;
        }
        String filePath = getServletContext().getRealPath("/") + "empleados.txt";
        // Guardar los datos en un archivo de texto
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(datosTrabajador);
            writer.newLine();
        }

        // Redirigir a una página de confirmación
        response.sendRedirect("confirmacion.html");
    }
}
