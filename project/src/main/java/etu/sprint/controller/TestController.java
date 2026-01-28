package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.annotation.PostMapping;
import etu.sprint.annotation.Authorized;
import etu.sprint.model.FileUpload;
import etu.sprint.model.ModelView;
import etu.sprint.model.Session;
import etu.sprint.util.AuthorizationManager;
import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@AnnotationController("/test")
public class TestController {

    @GetMapping("/hello")
    public String sayHello() {
        return "<h1>Hello from annotated method!</h1>";
    }

    @GetMapping("/bye")
    public String sayBye() {
        return "<h1>Goodbye from annotated method!</h1>";
    }
    @GetMapping("/uploadForm")
    public ModelView uploadForm() {
        ModelView mv = new ModelView();
        mv.setView("/views/upload.jsp");
        return mv;
    }

    @PostMapping("/upload")
    public ModelView upload(FileUpload file, HttpServletRequest request) {
        ModelView mv = new ModelView();
        mv.setView("/views/result.jsp");
        if (file != null) {
            String uploadPath = request.getServletContext().getRealPath("/uploads/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                String fullPath = uploadPath + file.getFileName();
                Files.write(Paths.get(fullPath), file.getBytes());
                mv.addObject("fileName", file.getFileName());
                mv.addObject("fileSize", file.getBytes().length);
                mv.addObject("contentType", file.getContentType());
                mv.addObject("serverPath", fullPath);
            } catch (IOException e) {
                mv.addObject("error", "Failed to save file: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            mv.addObject("fileName", "No file uploaded");
        }
        return mv;
    }

    @GetMapping("/files")
    public ModelView listFiles(HttpServletRequest request) {
        ModelView mv = new ModelView();
        mv.setView("/views/file-list.jsp");

        String uploadPath = request.getServletContext().getRealPath("/uploads/");
        File uploadDir = new File(uploadPath);
        List<String> files = new ArrayList<>();

        if (uploadDir.exists() && uploadDir.isDirectory()) {
            File[] fileList = uploadDir.listFiles();
            if (fileList != null) {
                for (File file : fileList) {
                    if (file.isFile()) {
                        files.add(file.getName());
                    }
                }
            }
        }
        mv.addObject("files", files);
        return mv;
    }

    // ========== SPRINT 11: Tests de gestion de session ==========

    /**
     * Test: Ajouter une valeur à la session
     * GET /test/session/set?key=username&value=john
     */
    @GetMapping("/session/set")
    public String setSessionValue(String key, String value, Session session) {
        if (key != null && value != null && session != null) {
            session.set(key, value);
            return "<h1>Session value set!</h1><p>Key: " + key + "</p><p>Value: " + value + "</p>";
        }
        return "<h1>Error: Missing key or value parameter</h1>";
    }

    /**
     * Test: Récupérer une valeur de la session
     * GET /test/session/get?key=username
     */
    @GetMapping("/session/get")
    public String getSessionValue(String key, Session session) {
        if (key != null && session != null) {
            Object value = session.get(key);
            if (value != null) {
                return "<h1>Session value retrieved!</h1><p>Key: " + key + "</p><p>Value: " + value.toString() + "</p>";
            } else {
                return "<h1>No value found for key: " + key + "</h1>";
            }
        }
        return "<h1>Error: Missing key parameter</h1>";
    }

    /**
     * Test: Afficher toutes les valeurs de la session
     * GET /test/session/all
     */
    @GetMapping("/session/all")
    public String getAllSessionValues(Session session) {
        if (session != null) {
            StringBuilder html = new StringBuilder("<h1>All Session Values</h1><ul>");
            session.getAll().forEach((k, v) -> {
                html.append("<li><strong>").append(k).append("</strong>: ").append(v != null ? v.toString() : "null").append("</li>");
            });
            html.append("</ul>");
            html.append("<p>Session ID: ").append(session.getId()).append("</p>");
            return html.toString();
        }
        return "<h1>Error: Session is null</h1>";
    }

    /**
     * Test: Supprimer une valeur de la session
     * GET /test/session/remove?key=username
     */
    @GetMapping("/session/remove")
    public String removeSessionValue(String key, Session session) {
        if (key != null && session != null) {
            boolean existed = session.contains(key);
            session.remove(key);
            if (existed) {
                return "<h1>Session value removed!</h1><p>Key: " + key + " was removed</p>";
            } else {
                return "<h1>Key not found in session: " + key + "</h1>";
            }
        }
        return "<h1>Error: Missing key parameter</h1>";
    }

    /**
     * Test: Exemple complet avec ModelView et session
     * GET /test/session/demo
     */
    @GetMapping("/session/demo")
    public ModelView sessionDemo(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/session-demo.jsp");
        
        // Ajouter quelques valeurs de test
        session.set("user", "testuser");
        session.set("loginCount", 5);
        session.set("lastLogin", "2024-01-01");
        
        // Récupérer les valeurs pour les passer à la vue
        mv.addObject("user", session.get("user"));
        mv.addObject("loginCount", session.get("loginCount"));
        mv.addObject("lastLogin", session.get("lastLogin"));
        mv.addObject("sessionId", session.getId());
        mv.addObject("allSessionData", session.getAll());
        
        return mv;
    }

    /**
     * Test: Invalider la session (déconnexion)
     * GET /test/session/invalidate
     */
    @GetMapping("/session/invalidate")
    public String invalidateSession(Session session) {
        if (session != null) {
            String sessionId = session.getId();
            session.invalidate();
            return "<h1>Session invalidated!</h1><p>Session ID: " + sessionId + " has been invalidated</p>";
        }
        return "<h1>Error: Session is null</h1>";
    }

    // ========== SPRINT 11bis: Tests de protection et rôles ==========

    /**
     * Test: Route accessible à tous (pas de restriction)
     * GET /test/auth/public
     */
    @GetMapping("/auth/public")
    @Authorized({"all"})
    public ModelView publicRoute(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/public.jsp");
        return mv;
    }

    /**
     * Test: Route accessible uniquement aux utilisateurs non authentifiés
     * GET /test/auth/anonym-only
     */
    @GetMapping("/auth/anonym-only")
    @Authorized({"anonym"})
    public ModelView anonymOnlyRoute() {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/anonym.jsp");
        return mv;
    }

    /**
     * Test: Route accessible uniquement aux administrateurs
     * GET /test/auth/admin-only
     */
    @GetMapping("/auth/admin-only")
    @Authorized({"admin"})
    public ModelView adminOnlyRoute(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/admin.jsp");
        mv.addObject("username", AuthorizationManager.getCurrentUser(session));
        mv.addObject("role", AuthorizationManager.getCurrentUserRole(session));
        return mv;
    }

    /**
     * Test: Route accessible aux admins et autres rôles (exemple)
     * GET /test/auth/authenticated
     */
    @GetMapping("/auth/authenticated")
    @Authorized({"authenticated"})
    public ModelView authenticatedRoute(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/authenticated.jsp");
        mv.addObject("username", AuthorizationManager.getCurrentUser(session));
        mv.addObject("role", AuthorizationManager.getCurrentUserRole(session));
        return mv;
    }

    /**
     * Test: Page de connexion (simulée)
     * GET /test/auth/login?username=admin&role=admin
     * GET /test/auth/login?username=user&role=user
     */
    @GetMapping("/auth/login")
    @Authorized({"anonym"})
    public ModelView login(String username, String role, Session session, HttpServletRequest request) {
        ModelView mv = new ModelView();
        if (username == null || username.isEmpty()) {
            AuthorizationManager am = new AuthorizationManager(request.getServletContext());
            mv.setView("/views/authorized/login.jsp");
            mv.addObject("roles", am.getConfiguredRoles());
            return mv;
        }
        if (session != null) {
            AuthorizationManager am = new AuthorizationManager(request.getServletContext());
            String effectiveRole = (role == null || role.isEmpty()) ? am.getDefaultRole() : role;
            AuthorizationManager.setAuthenticatedUser(session, username, effectiveRole);
            mv.setView("/views/authorized/status.jsp");
            mv.addObject("authenticated", true);
            mv.addObject("username", username);
            mv.addObject("role", effectiveRole);
            mv.addObject("sessionId", session.getId());
            return mv;
        }
        mv.setView("/views/authorized/login.jsp");
        mv.addObject("error", "Erreur de connexion");
        return mv;
    }

    @PostMapping("/auth/login")
    @Authorized({"anonym"})
    public ModelView doLogin(String username, String role, Session session, HttpServletRequest request) {
        ModelView mv = new ModelView();
        if (username == null || username.isEmpty()) {
            mv.setView("/views/authorized/login.jsp");
            mv.addObject("error", "Veuillez saisir un nom d'utilisateur");
            return mv;
        }
        AuthorizationManager am = new AuthorizationManager(request.getServletContext());
        String effectiveRole = (role == null || role.isEmpty()) ? am.getDefaultRole() : role;
        AuthorizationManager.setAuthenticatedUser(session, username, effectiveRole);
        mv.setView("/views/authorized/status.jsp");
        mv.addObject("authenticated", true);
        mv.addObject("username", AuthorizationManager.getCurrentUser(session));
        mv.addObject("role", AuthorizationManager.getCurrentUserRole(session));
        mv.addObject("sessionId", session.getId());
        return mv;
    }

    /**
     * Test: Déconnexion
     * GET /test/auth/logout
     */
    @GetMapping("/auth/logout")
    public ModelView logout(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/logout.jsp");
        String username = AuthorizationManager.getCurrentUser(session);
        AuthorizationManager.logout(session);
        mv.addObject("username", username);
        return mv;
    }

    /**
     * Test: Voir le statut de l'authentification
     * GET /test/auth/status
     */
    @GetMapping("/auth/status")
    public ModelView authStatus(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/status.jsp");
        boolean isAuthenticated = false;
        String username = null;
        String role = null;
        String sessionId = null;
        if (session != null) {
            username = AuthorizationManager.getCurrentUser(session);
            role = AuthorizationManager.getCurrentUserRole(session);
            isAuthenticated = username != null;
            sessionId = session.getId();
        }
        mv.addObject("authenticated", isAuthenticated);
        mv.addObject("username", username);
        mv.addObject("role", role);
        mv.addObject("sessionId", sessionId);
        return mv;
    }
}
