package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.annotation.Authorized;
import etu.sprint.model.ModelView;
import etu.sprint.model.Session;
import etu.sprint.util.AuthorizationManager;
import jakarta.servlet.http.HttpServletRequest;

@AnnotationController("/roles")
public class RoleTestController {

    @GetMapping("/status")
    public ModelView status(Session session) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/status.jsp");
        String username = AuthorizationManager.getCurrentUser(session);
        String role = AuthorizationManager.getCurrentUserRole(session);
        mv.addObject("authenticated", username != null);
        mv.addObject("username", username);
        mv.addObject("role", role);
        mv.addObject("sessionId", session != null ? session.getId() : null);
        return mv;
    }

    @GetMapping("/manager")
    @Authorized({"manager"})
    public ModelView manager(Session session) {
        ModelView mv = baseRoleView(session, "manager", "Zone Manager seulement");
        return mv;
    }

    @GetMapping("/editor")
    @Authorized({"editor"})
    public ModelView editor(Session session) {
        ModelView mv = baseRoleView(session, "editor", "Zone Editor seulement");
        return mv;
    }

    @GetMapping("/viewer")
    @Authorized({"viewer"})
    public ModelView viewer(Session session) {
        ModelView mv = baseRoleView(session, "viewer", "Zone Viewer seulement");
        return mv;
    }

    @GetMapping("/contributor")
    @Authorized({"contributor"})
    public ModelView contributor(Session session) {
        ModelView mv = baseRoleView(session, "contributor", "Zone Contributor seulement");
        return mv;
    }

    @GetMapping("/mng-or-edit")
    @Authorized({"manager", "editor"})
    public ModelView managerOrEditor(Session session) {
        ModelView mv = baseRoleView(session, AuthorizationManager.getCurrentUserRole(session), "Zone Manager ou Editor");
        mv.addObject("allowed", "manager, editor");
        return mv;
    }

    @GetMapping("/any-auth")
    @Authorized({"authenticated"})
    public ModelView anyAuthenticated(Session session) {
        ModelView mv = baseRoleView(session, AuthorizationManager.getCurrentUserRole(session), "Zone pour tout utilisateur authentifié");
        mv.addObject("allowed", "authenticated");
        return mv;
    }

    private ModelView baseRoleView(Session session, String requiredRole, String title) {
        ModelView mv = new ModelView();
        mv.setView("/views/authorized/role.jsp");
        mv.addObject("title", title);
        mv.addObject("requiredRole", requiredRole);
        mv.addObject("username", AuthorizationManager.getCurrentUser(session));
        mv.addObject("role", AuthorizationManager.getCurrentUserRole(session));
        return mv;
    }
}
