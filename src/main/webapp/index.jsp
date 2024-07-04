<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InterFace</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 500px;
            margin: 0 auto;
        }
        .actions, .form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .form label {
            margin-top: 10px;
        }
        .form input, .form select, .form textarea, .form button {
            margin-top: 5px;
            padding: 5px;
            font-size: 1rem;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="actions">
        <label for="action">Acción:</label>
        <select id="action" onchange="escogerAccion()">
            <option value="">Seleccione una acción</option>
            <option value="insertar">Insertar</option>
            <option value="modificar">Modificar</option>
            <option value="consultar">Consultar</option>
        </select>
    </div>
    <form id="form" class="form"></form>
</div>

<script>
    function escogerAccion() {
        const action = document.getElementById('action').value;
        const form = document.getElementById('form');
        form.innerHTML = '';

        if (action === 'insertar' || action === 'modificar') {
            const fields = `
            <label for="tipo-trabajador">Tipo de Trabajador:</label>
            <select id="tipo-trabajador" name="tipo-trabajador" onchange="seleccionarTipoEmpleado()">
                <option value="">Seleccione un tipo</option>
                <option value="empleado">Empleado</option>
                <option value="consultor">Consultor</option>
            </select>

            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre">

            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" name="direccion">

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono">

            <label for="cedula">Cédula:</label>
            <input type="text" id="cedula" name="cedula">

            <label for="departamento">Departamento:</label>
            <select id="departamento" name="departamento">
                <option value="ventas">Ventas</option>
                <option value="marketing">Marketing</option>
                <option value="it">IT</option>
                <option value="finanzas">Finanzas</option>
            </select>

            <label for="salario" id="salario-label" class="hidden">Salario:</label>
            <input type="text" id="salario" name="salario" class="hidden">

            <label for="deducciones" id="deducciones-label" class="hidden">Deducciones:</label>
            <input type="text" id="deducciones" name="deducciones" class="hidden">

            <label for="horas-trabajadas" id="horas-trabajadas-label" class="hidden">Horas Trabajadas:</label>
            <input type="text" id="horas-trabajadas" name="horas-trabajadas" class="hidden">

            <label for="tarifa-horaria" id="tarifa-horaria-label" class="hidden">Tarifa Horaria:</label>
            <input type="text" id="tarifa-horaria" name="tarifa-horaria" class="hidden">

            <button type="submit">Insertar</button>
        `;
            form.innerHTML = fields;

            if (action === 'modificar') {
                document.querySelector('button').innerText = 'Modificar';
                form.insertAdjacentHTML('afterbegin', `
                <label for="id-trabajador">Id Trabajadores:</label>
                <select id="id-trabajador" name="id-trabajador">

                </select>
            `);
                form.action = 'ServletModificar';

            } else {
                form.action = 'ServletInsertar';
            }

        } else if (action === 'consultar') {
            const fields = `
            <form id="form" class="form" action="ServletConsultar" method="GET">
                <label for="departamento-consulta">Departamento:</label>
                <select id="departamento-consulta" name="departamento-consulta">
                    <option value="ventas">Ventas</option>
                    <option value="marketing">Marketing</option>
                    <option value="it">IT</option>
                    <option value="finanzas">Finanzas</option>
                </select>
                <button type="button" onclick="consultarDepartamento()">Consultar</button>
                <textarea id="text-area-departamento" rows="10" cols="50" readonly></textarea>
            </form>
        `;
            form.innerHTML = fields;
            form.action = 'ServletConsultar';
        }
    }

    function seleccionarTipoEmpleado() {
        const tipo = document.getElementById('tipo-trabajador').value;
        const salarioField = document.getElementById('salario');
        const deduccionesField = document.getElementById('deducciones');
        const horasTrabajadasField = document.getElementById('horas-trabajadas');
        const tarifaHorariaField = document.getElementById('tarifa-horaria');

        const salarioLabel = document.getElementById('salario-label');
        const deduccionesLabel = document.getElementById('deducciones-label');
        const horasTrabajadasLabel = document.getElementById('horas-trabajadas-label');
        const tarifaHorariaLabel = document.getElementById('tarifa-horaria-label');

        if (tipo === 'empleado') {
            salarioField.classList.remove('hidden');
            deduccionesField.classList.remove('hidden');
            horasTrabajadasField.classList.add('hidden');
            tarifaHorariaField.classList.add('hidden');

            salarioLabel.classList.remove('hidden');
            deduccionesLabel.classList.remove('hidden');
            horasTrabajadasLabel.classList.add('hidden');
            tarifaHorariaLabel.classList.add('hidden');
        } else if (tipo === 'consultor') {
            salarioField.classList.add('hidden');
            deduccionesField.classList.add('hidden');
            horasTrabajadasField.classList.remove('hidden');
            tarifaHorariaField.classList.remove('hidden');

            salarioLabel.classList.add('hidden');
            deduccionesLabel.classList.add('hidden');
            horasTrabajadasLabel.classList.remove('hidden');
            tarifaHorariaLabel.classList.remove('hidden');
        } else {
            salarioField.classList.add('hidden');
            deduccionesField.classList.add('hidden');
            horasTrabajadasField.classList.add('hidden');
            tarifaHorariaField.classList.add('hidden');

            salarioLabel.classList.add('hidden');
            deduccionesLabel.classList.add('hidden');
            horasTrabajadasLabel.classList.add('hidden');
            tarifaHorariaLabel.classList.add('hidden');
        }
    }

    function consultarDepartamento() {
        const departamento = document.getElementById('departamento-consulta').value;
        fetch(`/ServletConsultar?departamento-consulta=${departamento}`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('text-area-departamento').value = data;
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('text-area-departamento').value = 'Error al realizar la consulta. Por favor, inténtelo de nuevo más tarde.';
            });
    }
</script>
</body>
</html>
