<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod"%>
<%
    List<Mod> mods = (List<Mod>) request.getAttribute("mods");
    String userLogin = (String) session.getAttribute("login");
    int userId = session.getAttribute("userId") != null ? (int) session.getAttribute("userId") : 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GameVerse Academy — Add Review</title>
<link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Orbitron:wght@400;600;700;900&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
<style>
:root {
    --sidebar-w: 270px;
    --bg: #07050f; --bg2: #0d0a1a; --panel: #110e22; --panel2: #1a1530;
    --purple: #8b5cf6; --purple-bright: #a78bfa;
    --pink: #ec4899; --pink-bright: #f472b6;
    --blue: #3b82f6; --blue-bright: #60a5fa; --cyan: #22d3ee;
    --amber: #f59e0b;
    --white: #f0eaff; --dim: #7c6fa0;
    --border: rgba(139,92,246,0.18); --border-bright: rgba(139,92,246,0.45);
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: var(--bg); color: var(--white); font-family: 'Inter', sans-serif; display: flex; min-height: 100vh; overflow-x: hidden; }
.blob { position: fixed; border-radius: 50%; filter: blur(120px); pointer-events: none; z-index: 0; opacity: 0.1; }
.blob-1 { width: 600px; height: 600px; background: var(--purple); top: -200px; left: -100px; }
.blob-2 { width: 500px; height: 500px; background: var(--pink); bottom: -150px; right: -50px; }
.sidebar { width: var(--sidebar-w); height: 100vh; position: fixed; top: 0; left: 0; background: rgba(8,6,20,0.95); border-right: 1px solid var(--border); backdrop-filter: blur(20px); display: flex; flex-direction: column; padding: 28px 18px; z-index: 100; }
.logo { font-family: 'Orbitron', sans-serif; font-size: 0.85rem; font-weight: 900; letter-spacing: 3px; text-align: center; padding: 10px 0 18px; background: linear-gradient(135deg, var(--purple-bright), var(--pink-bright), var(--blue-bright)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
.logo-divider { height: 1px; margin-bottom: 24px; background: linear-gradient(90deg, transparent, var(--purple), var(--pink), transparent); }
.nav-section { margin-bottom: 28px; }
.nav-label { font-size: 0.58rem; font-family: 'Orbitron', sans-serif; text-transform: uppercase; letter-spacing: 3px; color: var(--dim); margin-bottom: 10px; padding-left: 14px; display: block; }
.nav-item { display: flex; align-items: center; gap: 10px; padding: 11px 14px; border-radius: 10px; color: var(--dim); text-decoration: none; font-family: 'Rajdhani', sans-serif; font-size: 0.95rem; font-weight: 600; transition: all 0.25s; margin-bottom: 3px; border: none; background: none; cursor: pointer; width: 100%; text-align: left; }
.nav-item:hover, .nav-item.active { background: rgba(139,92,246,0.12); color: var(--white); }
.nav-item.active { color: var(--purple-bright); }
.sidebar-footer { margin-top: auto; border-top: 1px solid var(--border); padding: 14px; display: flex; flex-direction: column; gap: 12px; flex-shrink: 0; }
.user-chip { display: flex; align-items: center; gap: 10px; padding: 11px 14px; border-radius: 10px; background: rgba(139,92,246,0.08); border: 1px solid var(--border); }
.user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple), var(--pink)); display: flex; align-items: center; justify-content: center; font-size: 0.85rem; font-weight: 700; font-family: 'Orbitron'; flex-shrink: 0; }
.user-name { font-family: 'Rajdhani'; font-weight: 700; font-size: 0.9rem; color: var(--purple-bright); }
.user-role { font-size: 0.62rem; color: var(--dim); }
.main { margin-left: var(--sidebar-w); width: calc(100% - var(--sidebar-w)); min-height: 100vh; padding: 36px 40px; position: relative; z-index: 1; display: flex; flex-direction: column; align-items: center; justify-content: flex-start; }
.page-title { font-family: 'Orbitron', sans-serif; font-size: 1.4rem; font-weight: 700; background: linear-gradient(90deg, var(--purple-bright), var(--pink-bright)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 36px; align-self: flex-start; }

/* FORM CARD */
.form-card { background: var(--panel); border: 1px solid var(--border); border-radius: 20px; padding: 40px; width: 100%; max-width: 640px; position: relative; overflow: hidden; }
.form-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg, var(--purple), var(--pink), var(--blue)); }

.form-group { margin-bottom: 24px; }
.form-label { display: block; font-family: 'Rajdhani'; font-size: 0.8rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: var(--dim); margin-bottom: 10px; }
.form-control { width: 100%; background: rgba(139,92,246,0.06); border: 1px solid var(--border); border-radius: 10px; padding: 13px 16px; color: var(--white); font-family: 'Inter'; font-size: 0.9rem; outline: none; transition: all 0.3s; }
.form-control:focus { border-color: var(--purple); box-shadow: 0 0 0 3px rgba(139,92,246,0.15); background: rgba(139,92,246,0.1); }
.form-control option { background: #110e22; color: var(--white); }
textarea.form-control { resize: vertical; min-height: 120px; }

/* STAR RATING */
.star-rating { display: flex; gap: 8px; flex-direction: row-reverse; justify-content: flex-end; }
.star-rating input { display: none; }
.star-rating label { font-size: 2rem; color: rgba(139,92,246,0.2); cursor: pointer; transition: color 0.2s, transform 0.2s; }
.star-rating label:hover,
.star-rating label:hover ~ label,
.star-rating input:checked ~ label { color: var(--amber); }
.star-rating label:hover { transform: scale(1.2); }

/* BUTTONS */
.form-actions { display: flex; gap: 12px; margin-top: 32px; }
.btn-submit { flex: 1; padding: 14px; border-radius: 10px; background: linear-gradient(135deg, var(--purple), var(--pink)); color: white; font-family: 'Rajdhani'; font-size: 1rem; font-weight: 700; border: none; cursor: pointer; transition: all 0.3s; box-shadow: 0 4px 20px rgba(139,92,246,0.3); letter-spacing: 1px; }
.btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(139,92,246,0.5); }
.btn-cancel { padding: 14px 24px; border-radius: 10px; background: transparent; border: 1px solid var(--border); color: var(--dim); font-family: 'Rajdhani'; font-size: 1rem; font-weight: 700; cursor: pointer; transition: all 0.3s; text-decoration: none; display: flex; align-items: center; }
.btn-cancel:hover { border-color: var(--purple); color: var(--white); }

::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: var(--bg); }
::-webkit-scrollbar-thumb { background: linear-gradient(var(--purple), var(--pink)); border-radius: 99px; }
</style>
</head>
<body>
<div class="blob blob-1"></div>
<div class="blob blob-2"></div>

<aside class="sidebar">
    <div class="logo">⚡ GAMEVERSE ACADEMY</div>
    <div class="logo-divider"></div>
    <nav class="nav-section">
        <span class="nav-label">Navigation</span>
        <a href="mods" class="nav-item">🏠 Dashboard</a>
        <a href="ModSubmitController" class="nav-item">➕ Submit a Mod</a>
        <a href="reviews" class="nav-item active">⭐ Reviews</a>
    </nav>
    <nav class="nav-section">
        <span class="nav-label">Categories</span>
        <a href="mods?category=Graphique" class="nav-item">🎨 Graphics</a>
        <a href="mods?category=Gameplay" class="nav-item">🕹️ Gameplay</a>
        <a href="mods?category=Map" class="nav-item">🗺️ Maps</a>
        <a href="mods?category=Script" class="nav-item">📜 Scripts</a>
    </nav>
    <div class="sidebar-footer">
        <a href="index.html" class="nav-item">🚪 Logout</a>
        <div class="user-chip">
            <div class="user-avatar"><%= userLogin != null ? userLogin.substring(0,1).toUpperCase() : "G" %></div>
            <div>
                <div class="user-name"><%= userLogin != null ? userLogin : "Guest" %></div>
                <div class="user-role">Mod Creator</div>
            </div>
        </div>
    </div>
</aside>

<main class="main">
    <div class="page-title">➕ Add a Review</div>

    <div class="form-card">
        <form action="<%= request.getContextPath() %>/ReviewAddController" method="post">
            <input type="hidden" name="userId" value="<%= userId %>">

            <!-- MOD SELECT -->
            <div class="form-group">
                <label class="form-label">Select Mod</label>
                <select name="modId" class="form-control" required>
                    <option value="">— Choose a mod —</option>
                    <% if (mods != null) { for (Mod m : mods) { %>
                        <option value="<%= m.getId() %>"><%= m.getTitle() %></option>
                    <% } } %>
                </select>
            </div>

            <!-- STAR RATING -->
            <div class="form-group">
                <label class="form-label">Rating</label>
                <div class="star-rating">
                    <input type="radio" id="s5" name="rating" value="5"><label for="s5">★</label>
                    <input type="radio" id="s4" name="rating" value="4"><label for="s4">★</label>
                    <input type="radio" id="s3" name="rating" value="3" checked><label for="s3">★</label>
                    <input type="radio" id="s2" name="rating" value="2"><label for="s2">★</label>
                    <input type="radio" id="s1" name="rating" value="1"><label for="s1">★</label>
                </div>
            </div>

            <!-- COMMENT -->
            <div class="form-group">
                <label class="form-label">Comment</label>
                <textarea name="comment" class="form-control" placeholder="Share your thoughts about this mod..."></textarea>
            </div>

            <!-- ACTIONS -->
            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/reviews" class="btn-cancel">✕ Cancel</a>
                <button type="submit" class="btn-submit">⭐ Submit Review</button>
            </div>
        </form>
    </div>
</main>
</body>
</html>
