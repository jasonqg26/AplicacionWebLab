package main.java.com.example.aplicacionweblab;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;

@WebServlet("/ServletConsultar")
public class ServletConsultar extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departamentoConsulta = request.getParameter("departamento-consulta");

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String filePath = getServletContext().getRealPath("/") + "empleados.txt";
        out.println("Consultando el archivo: " + filePath); // Mensaje de depuración
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            boolean found = false;
            while ((line = reader.readLine()) != null) {
                String[] datos = line.split(",");
                String departamento = datos[5];
                if (departamento.equalsIgnoreCase(departamentoConsulta)) {
                    out.println(line);
                    found = true;
                }
            }
            if (!found) {
                out.println("No se encontraron empleados en el departamento: " + departamentoConsulta);
            }
        } catch (FileNotFoundException e) {
            out.println("El archivo empleados.txt no se encuentra.");
        } catch (IOException e) {
            out.println("Error al leer el archivo empleados.txt.");
        }
    }
}