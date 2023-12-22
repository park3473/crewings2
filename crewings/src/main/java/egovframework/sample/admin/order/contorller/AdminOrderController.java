package egovframework.sample.admin.order.contorller;

import javax.enterprise.inject.Model;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.sample.admin.order.model.AdminOrderVo;
import egovframework.sample.admin.order.service.AdminOrderService;

@Controller
public class AdminOrderController {

	@Autowired
	AdminOrderService adminOrderService;
	
	@RequestMapping(value="/admin/order/list.do"  , method = RequestMethod.GET)
	public ModelAndView AdminOrderAllList(@ModelAttribute("AdminOrderVo")AdminOrderVo AdminOrderVo , HttpServletRequest request , HttpServletResponse response) {
		
		System.out.println("PAGE : " + AdminOrderVo.getPAGE());
		System.out.println("ITEM_COUNT : " + AdminOrderVo.getITEM_COUNT());
		
		String PAGE = request.getParameter("PAGE") != null ? request.getParameter("PAGE ") : "0";
		String ITEM_COUNT = request.getParameter("ITEM_COUNT") != null ? request.getParameter("ITEM_COUNT") : "10";
		
		AdminOrderVo.setPAGE(Integer.parseInt(PAGE));
		AdminOrderVo.setITEM_COUNT(Integer.parseInt(ITEM_COUNT));
		
		int pagelimit = AdminOrderVo.getPAGE() * AdminOrderVo.getITEM_COUNT();
		
		AdminOrderVo.setLIMIT(Integer.parseInt(ITEM_COUNT));
		AdminOrderVo.setOFFSET(pagelimit);
		
		ModelMap model = new ModelMap();
		
		model = adminOrderService.getAllList(AdminOrderVo);
		
		model.put("before", AdminOrderVo);
		
		return new ModelAndView("admin/order/list" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/order/insert" , method = RequestMethod.GET)
	public String AdminOrderInsertGet(@ModelAttribute("AdminOrderVo")AdminOrderVo AdminOrderVo , HttpServletRequest request , HttpServletResponse response) {
		
		return "admin/order/insert";
		
	}
	
	@RequestMapping(value="/admin/order/insert" , method = RequestMethod.POST)
	public void AdminOrderInsertData(@ModelAttribute("AdminOrderVo")AdminOrderVo AdminOrderVo , HttpServletRequest request , HttpServletResponse response) {
		
		adminOrderService.setOrderData(AdminOrderVo , "insert");
		
	}
	
	@RequestMapping(value="/admin/order/view" ,  method = RequestMethod.GET)
	public ModelAndView AdminOrderViewData(@ModelAttribute("AdminOrderVo")AdminOrderVo AdminOrderVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = adminOrderService.getViewData(AdminOrderVo);
		
		return new ModelAndView("admin/order/view" , "model" , model);
		
	}
	
	
	@RequestMapping(value="/admin/order/update" , method = RequestMethod.POST)
	public void AdminOrderUpdateData(@ModelAttribute("AdminOrderVo")AdminOrderVo AdminOrderVo , HttpServletRequest request , HttpServletResponse response ) {
		
		adminOrderService.setOrderData(AdminOrderVo , "update");
		
	}
	
}
