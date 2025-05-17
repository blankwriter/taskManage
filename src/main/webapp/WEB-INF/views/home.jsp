<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TaskFlow Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        :root {
            --primary: #fff;
            --secondary: #f1f1f1;
            --text-dark: #333;
            --text-light: #777;
            --bg: #fff;
            --shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f7f9fb;
            color: var(--text-dark);
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: var(--primary);
            color: #fff;
            padding: 1rem 2rem;
            box-shadow: var(--shadow);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo img {
            width: 40px;
            height: 40px;
        }

        nav ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 1rem;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 0.5rem 1rem;
        }

        nav a:hover,
        nav .active a {
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 4px;
        }

        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .dashboard-header {
            margin-bottom: 2rem;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--bg);
            padding: 1.2rem;
            border-radius: 10px;
            text-align: center;
            box-shadow: var(--shadow);
        }

        .stat-value {
            font-size: 1.8rem;
            color: var(--primary);
            margin-top: 0.5rem;
        }

        .tasks-section {
            margin-bottom: 2rem;
        }

        .tasks-section h3 {
            border-bottom: 2px solid var(--primary);
            padding-bottom: 0.3rem;
        }

        .task-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: var(--shadow);
        }

        .task-table th,
        .task-table td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .task-table th {
            background-color: #f9f9f9;
            color: #555;
        }

        .task-item.highlight-overdue td {
            background-color: #fff3f3;
        }

        .status {
            font-weight: bold;
            padding: 0.3rem 0.6rem;
            border-radius: 5px;
            text-transform: capitalize;
        }

        .status-pending { background: #ffeb3b; }
        .status-inprogress { background: #2196f3; color: white; }
        .status-completed { background: #4caf50; color: white; }

        .task-actions a {
            margin-right: 0.5rem;
            padding: 0.4rem 0.8rem;
            text-decoration: none;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .btn-edit { background: #2196f3; color: white; }
        .btn-complete { background: #4caf50; color: white; }

        .quick-actions .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }

        .btn {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            text-align: center;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            font-size: 0.9rem;
        }
        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
                     display: inline-block;
                    padding: 8px 15px;
                    border-radius: 5px;
                    text-decoration: none;
                    font-weight: 500;
                    text-align: center;
                    border: none;
                    cursor: pointer;
                    transition: background-color 0.3s, transform 0.2s;
                    font-size: 0.9rem
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-secondary {
                        display: inline-block;
                        padding: 8px 15px;
                        border-radius: 5px;
                        text-decoration: none;
                        font-weight: 500;
                        text-align: center;
                        border: none;
                        cursor: pointer;
                        transition: background-color 0.3s, transform 0.2s;
                        font-size: 0.9rem
                        background-color: blue;

        .btn-secondary:hover {
            background-color: #e1e9f0;
        }


        footer {
            text-align: center;
            padding: 1rem;
            background: #f1f1f1;
            margin-top: 2rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/conquest.png" alt="TaskFlow Logo"
             onerror="this.src='${pageContext.request.contextPath}/static/img/default-logo.png';">
        <h1>TaskFlow</h1>
    </div>
    <nav>
        <ul>
            <li class="active"><a href="${pageContext.request.contextPath}/home">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/tasks">All Tasks</a></li>
            <li><a href="${pageContext.request.contextPath}/tasks/new">Create Task</a></li>
        </ul>
    </nav>
</header>

<main>
    <section class="dashboard-header">
        <h2>Welcome to Your Task Dashboard</h2>
        <p>Here's an overview of your current tasks and progress.</p>
    </section>

    <section class="stats-cards">
        <div class="stat-card"><h3>Pending</h3><div class="stat-value">${pendingCount}</div></div>
        <div class="stat-card"><h3>In Progress</h3><div class="stat-value">${inProgressCount}</div></div>
        <div class="stat-card"><h3>Completed</h3><div class="stat-value">${completedCount}</div></div>
        <div class="stat-card"><h3>Completion Rate</h3><div class="stat-value">${completionRate}%</div></div>
    </section>

    <section class="tasks-section overdue-tasks">
        <h3>Overdue Tasks <span class="task-count">(${overdueTasks.size()})</span></h3>
        <div class="task-list">
            <c:choose>
                <c:when test="${empty overdueTasks}">
                    <p class="no-tasks">No overdue tasks. Great job!</p>
                </c:when>
                <c:otherwise>
                    <table class="task-table">
                        <thead><tr><th>Title</th><th>Due Date</th><th>Status</th><th>Actions</th></tr></thead>
                        <tbody>
                        <c:forEach var="task" items="${overdueTasks}">
                            <tr class="task-item highlight-overdue">
                                <td>${task.title}</td>
                                <td><fmt:formatDate value="${task.dueDate}" pattern="yyyy-MM-dd"/></td>
                                <td><span class="status status-${task.status.name().toLowerCase()}">${task.status}</span></td>
                                <td class="task-actions">
                                    <a href="${pageContext.request.contextPath}/tasks/${task.id}/edit" class="btn-edit">Edit</a>
                                    <a href="#" onclick="completeTask(${task.id})" class="btn-complete">Complete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <section class="tasks-section today-tasks">
        <h3>Due Today <span class="task-count">(${todayTasks.size()})</span></h3>
        <div class="task-list">
            <c:choose>
                <c:when test="${empty todayTasks}">
                    <p class="no-tasks">No tasks due today.</p>
                </c:when>
                <c:otherwise>
                    <table class="task-table">
                        <thead><tr><th>Title</th><th>Status</th><th>Actions</th></tr></thead>
                        <tbody>
                        <c:forEach var="task" items="${todayTasks}">
                            <tr class="task-item">
                                <td>${task.title}</td>
                                <td><span class="status status-${task.status.name().toLowerCase()}">${task.status}</span></td>
                                <td class="task-actions">
                                    <a href="${pageContext.request.contextPath}/tasks/${task.id}/edit" class="btn-edit">Edit</a>
                                    <a href="#" onclick="completeTask(${task.id})" class="btn-complete">Complete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <section class="quick-actions">
        <h3>Quick Actions</h3>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/tasks/new" class="btn-primary">Create New Task</a>
            <a href="${pageContext.request.contextPath}/tasks?status=PENDING" class="btn-secondary">View Pending</a>
            <a href="${pageContext.request.contextPath}/tasks?status=COMPLETED" class="btn-secondary">View Completed</a>
        </div>
    </section>
</main>

<footer>
    <p>&copy; 2025 TaskFlow — Conquest Solutions</p>
</footer>

<script>
    const basePath = '${pageContext.request.contextPath}';
    function completeTask(taskId) {
        if (confirm('Mark this task as completed?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = basePath + '/tasks/' + taskId + '/complete';
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>

</body>
</html>
