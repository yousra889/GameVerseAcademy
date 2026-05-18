<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod"%>
<%
    List<Mod> mods = (List<Mod>) request.getAttribute("mods");
    String currentCategory = (String) request.getAttribute("category");
    String userLogin = (String) session.getAttribute("login");
    HashMap<String, String> gameImages = new HashMap<>();
    gameImages.put("skyrim", "https://media.rawg.io/media/games/7cf/7cfc9220b401b7a300e409e539c9afd5.jpg");
    gameImages.put("gta", "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg");
    gameImages.put("witcher", "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg");
    String fallbackImg = "https://media.rawg.io/media/screenshots/0e3/0e3f885f8f87143e33f3805ec6c2dfc9.jpg";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GameVerse Academy — Mods Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Orbitron:wght@400;600;700;900&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
<style>
:root {
    --sidebar-w: 270px;
    --bg: #07050f; --bg2: #0d0a1a; --panel: #110e22; --panel2: #1a1530;
    --purple: #8b5cf6; --purple-bright: #a78bfa;
    --pink: #ec4899; --pink-bright: #f472b6;
    --blue: #3b82f6; --blue-bright: #60a5fa; --cyan: #22d3ee;
    --white: #f0eaff; --dim: #7c6fa0;
    --border: rgba(139,92,246,0.18); --border-bright: rgba(139,92,246,0.45);
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: var(--bg); color: var(--white); font-family: 'Inter', sans-serif; display: flex; min-height: 100vh; overflow-x: hidden; }
.blob { position: fixed; border-radius: 50%; filter: blur(120px); pointer-events: none; z-index: 0; opacity: 0.1; }
.blob-1 { width: 600px; height: 600px; background: var(--purple); top: -200px; left: -100px; }
.blob-2 { width: 500px; height: 500px; background: var(--pink); bottom: -150px; right: -50px; }
.blob-3 { width: 400px; height: 400px; background: var(--blue); top: 35%; left: 35%; }

/* SIDEBAR */
.sidebar {
    width: var(--sidebar-w); height: 100vh; position: fixed; top: 0; left: 0;
    background: rgba(8,6,20,0.95); border-right: 1px solid var(--border);
    backdrop-filter: blur(20px); display: flex; flex-direction: column;
    padding: 28px 18px; z-index: 100;
}
.logo {
    font-family: 'Orbitron', sans-serif; font-size: 0.85rem; font-weight: 900;
    letter-spacing: 3px; text-align: center; padding: 10px 0 18px;
    background: linear-gradient(135deg, var(--purple-bright), var(--pink-bright), var(--blue-bright));
    -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
}
.logo-divider {
    height: 1px; margin-bottom: 24px;
    background: linear-gradient(90deg, transparent, var(--purple), var(--pink), transparent);
}
.nav-section { margin-bottom: 28px; }
.nav-label {
    font-size: 0.58rem; font-family: 'Orbitron', sans-serif;
    text-transform: uppercase; letter-spacing: 3px; color: var(--dim);
    margin-bottom: 10px; padding-left: 14px; display: block;
}
.nav-item {
    display: flex; align-items: center; gap: 10px; padding: 11px 14px; border-radius: 10px;
    color: var(--dim); text-decoration: none; font-family: 'Rajdhani', sans-serif;
    font-size: 0.95rem; font-weight: 600; transition: all 0.25s; margin-bottom: 3px;
    border: none; background: none; cursor: pointer; width: 100%; text-align: left;
}
.nav-item:hover, .nav-item.active { background: rgba(139,92,246,0.12); color: var(--white); }
.nav-item.active { color: var(--purple-bright); }
.sidebar-footer {
    margin-top: auto;                /* keeps it at the bottom */
    border-top: 1px solid var(--border);
    padding: 14px;                   /* some padding for logout */
    display: flex;                   
    flex-direction: column;          
    gap: 12px;                       
    flex-shrink: 0;                  
}
.sidebar-footer .nav-item {
    width: 100%;                     /* ensures the logout link fills container */
    justify-content: flex-start;
}

.user-chip {
    display: flex; align-items: center; gap: 10px; padding: 11px 14px;
    border-radius: 10px; background: rgba(139,92,246,0.08);
    border: 1px solid var(--border); margin-bottom: 10px;
}
.user-avatar {
    width: 34px; height: 34px; border-radius: 50%;
    background: linear-gradient(135deg, var(--purple), var(--pink));
    display: flex; align-items: center; justify-content: center;
    font-size: 0.85rem; font-weight: 700; font-family: 'Orbitron', sans-serif; flex-shrink: 0;
}
.user-name { font-family: 'Rajdhani', sans-serif; font-weight: 700; font-size: 0.9rem; color: var(--purple-bright); }
.user-role { font-size: 0.62rem; color: var(--dim); }

/* MAIN */
.main { margin-left: var(--sidebar-w); width: calc(100% - var(--sidebar-w)); min-height: 100vh; padding: 36px 40px; position: relative; z-index: 1; }

/* TOP BAR */
.top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 36px; }
.page-title { font-family: 'Orbitron', sans-serif; font-size: 1.4rem; font-weight: 700; background: linear-gradient(90deg, var(--purple-bright), var(--pink-bright)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
.search-wrap { position: relative; }
.search-wrap input {
    background: var(--panel); border: 1px solid var(--border); border-radius: 10px;
    padding: 11px 20px 11px 44px; color: var(--white); font-family: 'Inter'; font-size: 0.85rem;
    width: 280px; outline: none; transition: all 0.3s;
}
.search-wrap input::placeholder { color: var(--dim); }
.search-wrap input:focus { border-color: var(--purple); box-shadow: 0 0 0 3px rgba(139,92,246,0.15); }
.search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--dim); }

/* STATS */
.stats-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; margin-bottom: 36px; }
.stat-card {
    background: var(--panel); border: 1px solid var(--border); border-radius: 16px;
    padding: 22px 24px; display: flex; align-items: center; gap: 18px;
    position: relative; overflow: hidden; transition: border-color 0.3s, transform 0.3s;
}
.stat-card:hover { border-color: var(--border-bright); transform: translateY(-3px); }
.stat-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 2px; }
.c1::before { background: linear-gradient(90deg, var(--purple), var(--pink)); }
.c2::before { background: linear-gradient(90deg, var(--pink), var(--blue)); }
.c3::before { background: linear-gradient(90deg, var(--blue), var(--cyan)); }
.stat-icon-wrap { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; flex-shrink: 0; }
.c1 .stat-icon-wrap { background: rgba(139,92,246,0.15); }
.c2 .stat-icon-wrap { background: rgba(236,72,153,0.15); }
.c3 .stat-icon-wrap { background: rgba(59,130,246,0.15); }
.stat-val { font-family: 'Orbitron', sans-serif; font-size: 1.35rem; font-weight: 700; display: block; line-height: 1; }
.c1 .stat-val { color: var(--purple-bright); }
.c2 .stat-val { color: var(--pink-bright); }
.c3 .stat-val { color: var(--blue-bright); }
.stat-lbl { font-size: 0.7rem; color: var(--dim); font-family: 'Rajdhani'; letter-spacing: 1px; text-transform: uppercase; margin-top: 4px; display: block; }

/* SECTION HEADER */
.section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; }
.section-title {
    font-family: 'Rajdhani', sans-serif; font-size: 1.1rem; font-weight: 700;
    display: flex; align-items: center; gap: 10px;
}
.section-title::before { content: ''; width: 4px; height: 18px; border-radius: 2px; background: linear-gradient(to bottom, var(--purple), var(--pink)); }
.btn-submit {
    display: inline-flex; align-items: center; gap: 8px; padding: 10px 22px; border-radius: 10px;
    background: linear-gradient(135deg, var(--purple), var(--pink));
    color: white; text-decoration: none; font-family: 'Rajdhani'; font-size: 0.9rem; font-weight: 700;
    border: none; cursor: pointer; transition: all 0.3s;
    box-shadow: 0 4px 20px rgba(139,92,246,0.3);
}
.btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(139,92,246,0.5); }


.deco {
    display: inline-flex; align-items: center; gap: 8px; padding: 10px 22px; border-radius: 10px;
    background: linear-gradient(135deg, var(--purple), var(--pink));
    color: white; text-decoration: none; font-family: 'Rajdhani'; font-size: 0.9rem; font-weight: 700;
    border: none; cursor: pointer; transition: all 0.3s;
    box-shadow: 0 4px 20px rgba(139,92,246,0.3);
    align-self: flex-start;
    margin-left: 0;
}
.deco:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(139,92,246,0.5); }

.logout-form {
    display: flex;
}

.logout-form .deco {
    margin-right: auto;
}


/* MOD GRID */
.mod-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(290px, 1fr)); gap: 22px; }
.mod-card {
    background: var(--panel); border: 1px solid var(--border); border-radius: 16px;
    overflow: hidden; transition: all 0.35s; position: relative;
    animation: fadeUp 0.5s ease both;
}
.mod-card:hover { transform: translateY(-8px); border-color: rgba(139,92,246,0.5); box-shadow: 0 20px 60px rgba(0,0,0,0.5), 0 0 30px rgba(139,92,246,0.15); }
.card-img-wrap { position: relative; overflow: hidden; height: 165px; }
.card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s, filter 0.5s; filter: brightness(0.7) saturate(1.2); }
.mod-card:hover .card-img { transform: scale(1.08); filter: brightness(0.9) saturate(1.5); }
.card-overlay { position: absolute; inset: 0; background: linear-gradient(to top, var(--panel) 0%, transparent 60%); }
.badge {
    position: absolute; top: 10px; left: 10px; padding: 4px 10px; border-radius: 6px;
    font-family: 'Orbitron'; font-size: 0.55rem; font-weight: 700; letter-spacing: 1.5px;
    background: linear-gradient(135deg, #ec4899, #f43f5e); color: white;
    box-shadow: 0 0 15px rgba(236,72,153,0.6);
}
.card-cat {
    position: absolute; top: 10px; right: 10px; padding: 3px 8px; border-radius: 5px;
    font-size: 0.6rem; font-family: 'Rajdhani'; font-weight: 700; letter-spacing: 1px;
    background: rgba(139,92,246,0.3); border: 1px solid rgba(139,92,246,0.4);
    color: var(--purple-bright); backdrop-filter: blur(8px);
}
.card-body { padding: 18px 20px; }
.card-title { font-family: 'Rajdhani'; font-size: 1.05rem; font-weight: 700; color: var(--white); margin-bottom: 8px; line-height: 1.3; }
.card-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px; }
.card-author { font-size: 0.75rem; color: var(--dim); }
.card-dl { font-size: 0.75rem; color: var(--pink-bright); font-family: 'Orbitron'; }
.card-actions { display: flex; gap: 8px; }
.btn-card {
    flex: 1; padding: 9px 6px; border-radius: 8px; font-family: 'Rajdhani';
    font-size: 0.8rem; font-weight: 700; cursor: pointer; transition: all 0.25s;
    border: 1px solid; text-align: center; text-decoration: none;
    display: flex; align-items: center; justify-content: center;
}
.btn-view { background: transparent; border-color: rgba(139,92,246,0.4); color: var(--purple-bright); }
.btn-view:hover { background: rgba(139,92,246,0.15); border-color: var(--purple); }
.btn-edit { background: transparent; border-color: rgba(59,130,246,0.4); color: var(--blue-bright); }
.btn-edit:hover { background: rgba(59,130,246,0.12); border-color: var(--blue); }
.btn-del-form { flex: 1; }
.btn-del-form button { width: 100%; background: transparent; border: 1px solid rgba(236,72,153,0.35); border-radius: 8px; color: var(--pink); padding: 9px 6px; font-family: 'Rajdhani'; font-size: 0.8rem; font-weight: 700; cursor: pointer; transition: all 0.25s; }
.btn-del-form button:hover { background: rgba(236,72,153,0.1); border-color: var(--pink); }
.empty-state { grid-column: 1/-1; text-align: center; padding: 80px 20px; color: var(--dim); }
.empty-state .ei { font-size: 4rem; margin-bottom: 16px; }
.empty-state p { font-family: 'Rajdhani'; font-size: 1.1rem; }
::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: var(--bg); }
::-webkit-scrollbar-thumb { background: linear-gradient(var(--purple), var(--pink)); border-radius: 99px; }
@keyframes fadeUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
.mod-card:nth-child(1){animation-delay:0.05s} .mod-card:nth-child(2){animation-delay:0.10s}
.mod-card:nth-child(3){animation-delay:0.15s} .mod-card:nth-child(4){animation-delay:0.20s}
.mod-card:nth-child(5){animation-delay:0.25s} .mod-card:nth-child(6){animation-delay:0.30s}
</style>
</head>
<body>
<div class="blob blob-1"></div>
<div class="blob blob-2"></div>
<div class="blob blob-3"></div>

<aside class="sidebar">
    <div class="logo">⚡ GAMEVERSE ACADEMY</div>
    <div class="logo-divider"></div>
    <a href="reviews" class="nav-item">⭐ Reviews</a>

    <nav class="nav-section">
        <span class="nav-label">Navigation</span>
        <a href="mods" class="nav-item <%= currentCategory == null ? "active" : "" %>">🏠 Dashboard</a>
        <a href="ModSubmitController" class="nav-item">➕ Submit a Mod</a>
    </nav>

    <nav class="nav-section">
        <span class="nav-label">Categories</span>
        <a href="mods?category=Graphique" class="nav-item <%= "Graphique".equals(currentCategory) ? "active" : "" %>">🎨 Graphics</a>
        <a href="mods?category=Gameplay" class="nav-item <%= "Gameplay".equals(currentCategory) ? "active" : "" %>">🕹️ Gameplay</a>
        <a href="mods?category=Map" class="nav-item <%= "Map".equals(currentCategory) ? "active" : "" %>">🗺️ Maps</a>
        <a href="mods?category=Script" class="nav-item <%= "Script".equals(currentCategory) ? "active" : "" %>">📜 Scripts</a>
    </nav>

    <div class="sidebar-footer">
            <div style="margin-top: auto;">
            	<a href="index.html" class="nav-item"><span>🚪</span> Logout</a>
       		</div>
        
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
    <div class="top-bar">
        <div class="page-title"><%= currentCategory != null ? currentCategory : "All Mods" %></div>
        <div class="search-wrap">
            <span class="search-icon">🔍</span>
            <input type="text" id="modSearch" placeholder="Search mods..." onkeyup="filterMods()">
        </div>
    </div>


                    <div class="user-info">
				    <i class="bi bi-person-circle"></i>
				    <span>
				        <%= session.getAttribute("user") != null
				              ? session.getAttribute("user") : "Visiteur" %>
				    </span>
				</div >
				<form class="logout-form" action="<%= request.getContextPath() %>/LogoutController" method="post">
				    <button type="submit" class="deco">
				        <i class="bi bi-box-arrow-right"></i> Déconnexion
				    </button>
				</form>
				
				
				
    <div class="stats-row">
        <div class="stat-card c1">
            <div class="stat-icon-wrap">📦</div>
            <div><span class="stat-val"><%= mods != null ? mods.size() : 0 %></span><span class="stat-lbl">Active Mods</span></div>
        </div>
        <div class="stat-card c2">
            <div class="stat-icon-wrap">🔥</div>
            <div><span class="stat-val">Trending</span><span class="stat-lbl">Top Community Picks</span></div>
        </div>
        <div class="stat-card c3">
            <div class="stat-icon-wrap">💎</div>
            <div><span class="stat-val">Verified</span><span class="stat-lbl">Official Academy Content</span></div>
        </div>
    </div>

    <div class="section-header">
        <div class="section-title">Browse Mods</div>
        <a href="ModSubmitController" class="btn-submit">➕ Submit Mod</a>
    </div>

    <div class="mod-grid" id="modGrid">
        <% if (mods != null && !mods.isEmpty()) {
            for (Mod m : mods) {
                String foundImg = fallbackImg;
                String t = m.getTitle().toLowerCase();
                for (String key : gameImages.keySet()) { if (t.contains(key)) { foundImg = gameImages.get(key); break; } }
        %>
        <div class="mod-card mod-item" data-title="<%= m.getTitle().toLowerCase() %>">
            <div class="card-img-wrap">
                <img src="<%= foundImg %>" class="card-img" alt="cover">
                <div class="card-overlay"></div>
                <% if (m.getDownloads() > 500) { %><div class="badge">🔥 TRENDING</div><% } %>
                <% if (m.getCategory() != null) { %><div class="card-cat"><%= m.getCategory() %></div><% } %>
            </div>
            <div class="card-body">
                <div class="card-title"><%= m.getTitle() %></div>
                <div class="card-meta">
                    <span class="card-author">👤 <%= m.getAuthor() != null ? m.getAuthor() : "Unknown" %></span>
                    <span class="card-dl">📥 <%= m.getDownloads() %></span>
                </div>
                <div class="card-actions">
                    <button class="btn-card btn-view">👁 View</button>
                    <a href="<%= request.getContextPath() %>/ModEditController?id=<%= m.getId() %>" class="btn-card btn-edit">✏️ Edit</a>
                    <form action="<%= request.getContextPath() %>/ModDeleteController" method="post" class="btn-del-form">
                        <input type="hidden" name="id" value="<%= m.getId() %>">
                        <button type="submit">🗑 Delete</button>
                    </form>
                </div>
            </div>
        </div>
        <% } } else { %>
        <div class="empty-state"><div class="ei">🎮</div><p>No mods found. Be the first to submit one!</p></div>
        <% } %>
    </div>
</main>
<script>
function filterMods() {
    const q = document.getElementById('modSearch').value.toLowerCase();
    document.querySelectorAll('.mod-item').forEach(el => { el.style.display = el.dataset.title.includes(q) ? '' : 'none'; });
}
</script>
</body>
</html>
