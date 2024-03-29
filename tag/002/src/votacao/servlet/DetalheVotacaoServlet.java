package votacao.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import votacao.bean.Votacao;
import votacao.dao.DaoFactory;
import votacao.dao.VotacaoDao;
import votacao.exception.BaseException;

/**
 * Servlet implementation class ListaCandidatosServlet
 */
public class DetalheVotacaoServlet extends ServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see ServletBase#ServletBase()
	 */
	public DetalheVotacaoServlet() {
		super();
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws BaseException {

		try {
			int idVotacao = Integer.parseInt(request.getParameter("idVotacao"));

			VotacaoDao votacaoDao = DaoFactory.getInstance().getVotacaoDao();

			Votacao votacao = votacaoDao.buscarPorId(idVotacao);

			String nextJSP = "/restrito/eleitor/detalheVotacao.jsp";
			request.setAttribute("votacao", votacao);
			int random = (int)(Math.random()*999999999);
			request.setAttribute("random", String.format("%09d", random) );
			request.getRequestDispatcher(nextJSP).forward(request, response);
		} catch (Exception e) {
			throw new BaseException(e);
		}
	}

}
