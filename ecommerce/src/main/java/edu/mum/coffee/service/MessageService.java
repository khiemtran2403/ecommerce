package edu.mum.coffee.service;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MessageService {

	@Value("${userConfiguration.path}")
	private String location;

	public String getLoginMessage() throws FileNotFoundException {
		String loginMessage = "";

		Scanner br = new Scanner(new FileReader(location));

		StringBuilder sb = new StringBuilder();
		while (br.hasNext()) {
			sb.append(br.next() + " ");
		}
		br.close();
		loginMessage = sb.toString();

		return loginMessage;
	}
}
