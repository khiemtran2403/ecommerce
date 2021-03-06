package edu.mum.coffee.controller;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.Person;
import edu.mum.coffee.service.PersonService;

@Controller
@RequestMapping("/person")
public class PersonController {
	
	@Autowired
	private PersonService personService;
	
	@RequestMapping(method = RequestMethod.GET, value = "add")
	public String addPersonPage(Model model) {
		Person person = new Person();
		model.addAttribute("person", person);
		return "modifyPerson";
	}
	
	@RequestMapping(method = RequestMethod.GET, value="list")
	public String listAllPerson(@RequestParam(value = "index",required = false) String pageNumber, Model model) {
		
		Page<Person> page = personService.findPersonPagination(pageNumber == null ? 1 : Integer.parseInt(pageNumber));

	    int current = page.getNumber() + 1;
	    int begin = Math.max(1, current - 5);
	    int end = Math.min(begin + 10, page.getTotalPages());

	    model.addAttribute("deploymentLog", page);
	    model.addAttribute("beginIndex", begin);
	    model.addAttribute("endIndex", end);
	    model.addAttribute("currentIndex", current);
	
		model.addAttribute("persons", page.getContent());
		
		return "persons";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "modify" , method = RequestMethod.POST)
	public String modifyPerson(@ModelAttribute("person") @Valid Person person,BindingResult result, Model model) {
		if (!result.hasErrors()) {
			personService.savePerson(person);
		} else {
			model.addAttribute("person", person);
			return "modifyPerson"; 
		}
		
		Collection<SimpleGrantedAuthority> authorities = 
				(Collection<SimpleGrantedAuthority>) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		if ("ROLE_USER".equals(authorities.iterator().next().getAuthority())) {
			return "redirect:/home";
		} else {
			return "redirect:list";
		}
	}
}
