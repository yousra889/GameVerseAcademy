<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod" %>
<% Mod mod = (Mod) request.getAttribute("mod"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Mod — GameVerse Academy</title>
<link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Orbitron:wght@400;600;700;900&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
<style>
:root {
    --bg: #07050f; --panel: #110e22; --panel2: #1a1530;
    --purple: #8b5cf6; --purple-bright: #a78bfa;
    --pink: #ec4899; --pink-bright: #f472b6;
    --blue: #3b82f6; --blue-bright: #60a5fa;
    --white: #f0eaff; --dim: #7c6fa0;
    --border: rgba(139,92,246,0.18); --border-focus: rgba(139,92,246,0.55);
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
    background: var(--bg); color: var(--white);
    font-family: 'Inter', sans-serif; min-height: 100vh;
    display: flex; align-items: center; justify-content: center; padding: 40px 20px;
    position: relative; overflow-x: hidden;
}
.blob { position: fixed; border-radius: 50%; filter: blur(120px); pointer-events: none; z-index: 0; opacity: 0.1; }
.blob-1 { width: 500px; height: 500px; background: var(--purple); top: -150px; left: -100px; }
.blob-2 { width: 400px; height: 400px; background: var(--pink); bottom: -120px; right: -80px; }

.card {
    background: rgba(17,14,34,0.9); border: 1px solid var(--border);
    border-radius: 24px; padding: 44px 40px; width: 100%; max-width: 520px;
    position: relative; z-index: 1;
    backdrop-filter: blur(20px);
    box-shadow: 0 30px 80px rgba(0,0,0,0.5), 0 0 0 1px rgba(139,92,246,0.08);
    animation: slideUp 0.5s ease;
}
.card::before {
    content: ''; position: absolute; top: 0; left: 30px; right: 30px; height: 2px;
    background: linear-gradient(90deg, transparent, var(--purple), var(--pink), transparent);
    border-radius: 0 0 2px 2px;
}

.header { text-align: center; margin-bottom: 36px; }
.header-icon { font-size: 2.5rem; margin-bottom: 12px; }
.header h1 {
    font-family: 'Orbitron', sans-serif; font-size: 1.3rem; font-weight: 700;
    background: linear-gradient(135deg, var(--purple-bright), var(--pink-bright));
    -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    margin-bottom: 6px;
}
.header p { font-size: 0.8rem; color: var(--dim); }

.field-group { margin-bottom: 20px; }
label {
    display: block; font-family: 'Rajdhani', sans-serif; font-size: 0.8rem;
    font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px;
    color: var(--dim); margin-bottom: 8px;
}
input[type="text"], textarea {
    width: 100%; padding: 13px 16px;
    background: rgba(26,21,48,0.8); border: 1px solid var(--border);
    border-radius: 10px; color: var(--white);
    font-family: 'Inter', sans-serif; font-size: 0.9rem;
    outline: none; transition: all 0.3s; resize: none;
}
input[type="text"]:focus, textarea:focus {
    border-color: var(--purple);
    box-shadow: 0 0 0 3px rgba(139,92,246,0.15), 0 0 20px rgba(139,92,246,0.1);
    background: rgba(139,92,246,0.05);
}
input[type="text"]::placeholder, textarea::placeholder { color: var(--dim); }
textarea { height: 110px; }

.btn-row { display: flex; gap: 12px; margin-top: 30px; }
.btn-update {
    flex: 1; padding: 14px; border-radius: 12px;
    background: linear-gradient(135deg, var(--purple), var(--pink));
    color: white; border: none; font-family: 'Orbitron', sans-serif;
    font-size: 0.8rem; font-weight: 700; letter-spacing: 1px; cursor: pointer;
    transition: all 0.3s; box-shadow: 0 4px 20px rgba(139,92,246,0.4);
}
.btn-update:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(139,92,246,0.6); }
.btn-cancel {
    padding: 14px 20px; border-radius: 12px;
    background: transparent; border: 1px solid var(--border);
    color: var(--dim); font-family: 'Rajdhani', sans-serif;
    font-size: 0.9rem; font-weight: 700; cursor: pointer;
    text-decoration: none; display: flex; align-items: center;
    transition: all 0.25s;
}
.btn-cancel:hover { border-color: var(--purple); color: var(--purple-bright); }

@keyframes slideUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
</style>
</head>
<body>
<div class="blob blob-1"></div>
<div class="blob blob-2"></div>

<div class="card">
    <div class="header">
        <div class="header-icon">✏️</div>
        <h1>Edit Mod</h1>
        <p>Update your mod details below</p>
    </div>

    <form action="<%= request.getContextPath() %>/ModEditController" method="post">
        <input type="hidden" name="id" value="<%= mod.getId() %>">

        <div class="field-group">
            <label>Title</label>
            <input type="text" name="title" value="<%= mod.getTitle() %>" placeholder="Mod title" required>
        </div>

        <div class="field-group">
            <label>Category</label>
            <input type="text" name="category" value="<%= mod.getCategory() %>" placeholder="e.g. Graphique, Gameplay">
        </div>

        <div class="field-group">
            <label>Author</label>
            <input type="text" name="author" value="<%= mod.getAuthor() %>" placeholder="Your name or username">
        </div>

        <div class="field-group">
            <label>Description</label>
            <textarea name="description" placeholder="Describe your mod..."><%= mod.getDescription() %></textarea>
        </div>

        <div class="btn-row">
            <a href="<%= request.getContextPath() %>/mods" class="btn-cancel">← Cancel</a>
            <button type="submit" class="btn-update">⚡ Update Mod</button>
        </div>
    </form>
</div>
</body>
</html>
