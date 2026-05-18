<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ma.ac.esi.gameverseacademy.model.Review"%>
<%
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    String userLogin = (String) session.getAttribute("login");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GameVerse Academy — Reviews</title>
<link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Orbitron:wght@400;600;700;900&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
<style>
:root {
    --sidebar-w: 270px;
    --bg: #07050f; --bg2: #0d0a1a; --panel: #110e22; --panel2: #1a1530;
    --purple: #8b5cf6; --purple-bright: #a78bfa;
    --pink: #ec4899; --pink-bright: #f472b6;
    --blue: #3b82f6; --blue-bright: #60a5fa; --cyan: #22d3ee;
    --green: #10b981; --amber: #f59e0b;
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
.logo-divider { height: 1px; margin-bottom: 24px; background: linear-gradient(90deg, transparent, var(--purple), var(--pink), transparent); }
.nav-section { margin-bottom: 28px; }
.nav-label { font-size: 0.58rem; font-family: 'Orbitron', sans-serif; text-transform: uppercase; letter-spacing: 3px; color: var(--dim); margin-bottom: 10px; padding-left: 14px; display: block; }
.nav-item { display: flex; align-items: center; gap: 10px; padding: 11px 14px; border-radius: 10px; color: var(--dim); text-decoration: none; font-family: 'Rajdhani', sans-serif; font-size: 0.95rem; font-weight: 600; transition: all 0.25s; margin-bottom: 3px; border: none; background: none; cursor: pointer; width: 100%; text-align: left; }
.nav-item:hover, .nav-item.active { background: rgba(139,92,246,0.12); color: var(--white); }
.nav-item.active { color: var(--purple-bright); }
.sidebar-footer { margin-top: auto; border-top: 1px solid var(--border); padding: 14px; display: flex; flex-direction: column; gap: 12px; flex-shrink: 0; }
.user-chip { display: flex; align-items: center; gap: 10px; padding: 11px 14px; border-radius: 10px; background: rgba(139,92,246,0.08); border: 1px solid var(--border); }
.user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple), var(--pink)); display: flex; align-items: center; justify-content: center; font-size: 0.85rem; font-weight: 700; font-family: 'Orbitron', sans-serif; flex-shrink: 0; }
.user-name { font-family: 'Rajdhani', sans-serif; font-weight: 700; font-size: 0.9rem; color: var(--purple-bright); }
.user-role { font-size: 0.62rem; color: var(--dim); }

/* MAIN */
.main { margin-left: var(--sidebar-w); width: calc(100% - var(--sidebar-w)); min-height: 100vh; padding: 36px 40px; position: relative; z-index: 1; }

/* TOP BAR */
.top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 36px; }
.page-title { font-family: 'Orbitron', sans-serif; font-size: 1.4rem; font-weight: 700; background: linear-gradient(90deg, var(--purple-bright), var(--pink-bright)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }

/* STATS */
.stats-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; margin-bottom: 36px; }
.stat-card { background: var(--panel); border: 1px solid var(--border); border-radius: 16px; padding: 22px 24px; display: flex; align-items: center; gap: 18px; position: relative; overflow: hidden; transition: border-color 0.3s, transform 0.3s; }
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
.section-title { font-family: 'Rajdhani', sans-serif; font-size: 1.1rem; font-weight: 700; display: flex; align-items: center; gap: 10px; }
.section-title::before { content: ''; width: 4px; height: 18px; border-radius: 2px; background: linear-gradient(to bottom, var(--purple), var(--pink)); }
.btn-submit { display: inline-flex; align-items: center; gap: 8px; padding: 10px 22px; border-radius: 10px; background: linear-gradient(135deg, var(--purple), var(--pink)); color: white; text-decoration: none; font-family: 'Rajdhani'; font-size: 0.9rem; font-weight: 700; border: none; cursor: pointer; transition: all 0.3s; box-shadow: 0 4px 20px rgba(139,92,246,0.3); }
.btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(139,92,246,0.5); }

/* REVIEWS TABLE */
.review-table-wrap { background: var(--panel); border: 1px solid var(--border); border-radius: 16px; overflow: hidden; }
.review-table { width: 100%; border-collapse: collapse; }
.review-table thead tr { background: rgba(139,92,246,0.08); border-bottom: 1px solid var(--border); }
.review-table th { padding: 14px 20px; text-align: left; font-family: 'Orbitron', sans-serif; font-size: 0.6rem; letter-spacing: 2px; color: var(--dim); text-transform: uppercase; font-weight: 600; }
.review-table td { padding: 16px 20px; border-bottom: 1px solid rgba(139,92,246,0.06); vertical-align: middle; }
.review-table tbody tr { transition: background 0.2s; animation: fadeUp 0.4s ease both; }
.review-table tbody tr:hover { background: rgba(139,92,246,0.05); }
.review-table tbody tr:last-child td { border-bottom: none; }

/* STARS */
.stars { display: flex; gap: 3px; }
.star { font-size: 1rem; }
.star.filled { color: var(--amber); }
.star.empty { color: rgba(139,92,246,0.2); }

/* MOD BADGE */
.mod-badge { display: inline-flex; align-items: center; padding: 4px 10px; border-radius: 6px; background: rgba(139,92,246,0.12); border: 1px solid var(--border); font-family: 'Rajdhani'; font-size: 0.8rem; color: var(--purple-bright); font-weight: 600; }

/* USER CHIP inline */
.user-inline { display: flex; align-items: center; gap: 8px; }
.user-dot { width: 28px; height: 28px; border-radius: 50%; background: linear-gradient(135deg, var(--purple), var(--pink)); display: flex; align-items: center; justify-content: center; font-size: 0.7rem; font-weight: 700; font-family: 'Orbitron'; flex-shrink: 0; }
.user-inline span { font-family: 'Rajdhani'; font-size: 0.9rem; color: var(--white); font-weight: 600; }

/* COMMENT */
.comment-text { font-size: 0.85rem; color: var(--dim); max-width: 300px; line-height: 1.5; }

/* ACTIONS */
.actions { display: flex; gap: 8px; }
.btn-card { padding: 7px 14px; border-radius: 8px; font-family: 'Rajdhani'; font-size: 0.8rem; font-weight: 700; cursor: pointer; transition: all 0.25s; border: 1px solid; text-align: center; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; }
.btn-edit { background: transparent; border-color: rgba(59,130,246,0.4); color: var(--blue-bright); }
.btn-edit:hover { background: rgba(59,130,246,0.12); border-color: var(--blue); }
.btn-del-form button { background: transparent; border: 1px solid rgba(236,72,153,0.35); border-radius: 8px; color: var(--pink); padding: 7px 14px; font-family: 'Rajdhani'; font-size: 0.8rem; font-weight: 700; cursor: pointer; transition: all 0.25s; display: inline-flex; align-items: center; gap: 5px; }
.btn-del-form button:hover { background: rgba(236,72,153,0.1); border-color: var(--pink); }

/* DATE */
.date-text { font-size: 0.75rem; color: var(--dim); font-family: 'Rajdhani'; }

/* EMPTY */
.empty-state { text-align: center; padding: 80px 20px; color: var(--dim); }
.empty-state .ei { font-size: 4rem; margin-bottom: 16px; }
.empty-state p { font-family: 'Rajdhani'; font-size: 1.1rem; }

::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: var(--bg); }
::-webkit-scrollbar-thumb { background: linear-gradient(var(--purple), var(--pink)); border-radius: 99px; }
@keyframes fadeUp { from { opacity: 0; transform: translateY(12px); } to { opacity: 1; transform: translateY(0); } }
</style>
</head>
<body>
<div class="blob blob-1"></div>
<div class="blob blob-2"></div>
<div class="blob blob-3"></div>

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
    <div class="top-bar">
        <div class="page-title">⭐ Community Reviews</div>
    </div>

    <!-- STATS -->
    <div class="stats-row">
        <div class="stat-card c1">
            <div class="stat-icon-wrap">⭐</div>
            <div><span class="stat-val"><%= reviews != null ? reviews.size() : 0 %></span><span class="stat-lbl">Total Reviews</span></div>
        </div>
        <div class="stat-card c2">
            <div class="stat-icon-wrap">🔥</div>
            <div><span class="stat-val">Top Rated</span><span class="stat-lbl">Community Picks</span></div>
        </div>
        <div class="stat-card c3">
            <div class="stat-icon-wrap">💬</div>
            <div><span class="stat-val">Active</span><span class="stat-lbl">Community Feedback</span></div>
        </div>
    </div>

    <!-- SECTION HEADER -->
    <div class="section-header">
        <div class="section-title">All Reviews</div>
        <a href="<%= request.getContextPath() %>/ReviewAddController" class="btn-submit">➕ Add Review</a>
    </div>

    <!-- TABLE -->
    <div class="review-table-wrap">
        <% if (reviews != null && !reviews.isEmpty()) { %>
        <table class="review-table">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Mod</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% for (Review r : reviews) { %>
                <tr style="animation-delay: <%= reviews.indexOf(r) * 0.05 %>s">
                    <td>
                        <div class="user-inline">
                            <div class="user-dot"><%= r.getUserLogin() != null ? r.getUserLogin().substring(0,1).toUpperCase() : "?" %></div>
                            <span><%= r.getUserLogin() != null ? r.getUserLogin() : "Unknown" %></span>
                        </div>
                    </td>
                    <td><span class="mod-badge">🎮 <%= r.getModTitle() != null ? r.getModTitle() : "—" %></span></td>
                    <td>
                        <div class="stars">
                            <% for (int i = 1; i <= 5; i++) { %>
                                <span class="star <%= i <= r.getRating() ? "filled" : "empty" %>">★</span>
                            <% } %>
                        </div>
                    </td>
                    <td><div class="comment-text"><%= r.getComment() != null ? r.getComment() : "—" %></div></td>
                    <td><div class="date-text"><%= r.getCreatedAt() != null ? r.getCreatedAt().toString().substring(0,10) : "—" %></div></td>
                    <td>
                        <div class="actions">
                            <a href="<%= request.getContextPath() %>/ReviewEditController?id=<%= r.getId() %>" class="btn-card btn-edit">✏️ Edit</a>
                            <form action="<%= request.getContextPath() %>/ReviewDeleteController" method="post" class="btn-del-form">
                                <input type="hidden" name="id" value="<%= r.getId() %>">
                                <button type="submit" onclick="return confirm('Delete this review?')">🗑 Delete</button>
                            </form>
                        </div>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div class="empty-state">
            <div class="ei">⭐</div>
            <p>No reviews yet. Be the first to review a mod!</p>
        </div>
        <% } %>
    </div>
</main>
</body>
</html>
