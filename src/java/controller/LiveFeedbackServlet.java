package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.DummyDataLiveFeedback;

@WebServlet(name = "LiveFeedbackServlet", urlPatterns = {"/liveFeedback"})
public class LiveFeedbackServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        
        HttpSession session = request.getSession(true);
        
        List<Integer> tbm = DummyDataLiveFeedback.hentDummyTilbakemeldinger();
        java.util.Collections.sort(tbm);
        //session.setAttribute("data", tbm); 60 == antall minutter skalbli en variabel.
        request.setAttribute("data", DummyDataLiveFeedback.lagFrekvensTabell(tbm, 60));
        request.getRequestDispatcher("WEB-INF/LiveFeedback.jsp").forward(request, response);
                
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
