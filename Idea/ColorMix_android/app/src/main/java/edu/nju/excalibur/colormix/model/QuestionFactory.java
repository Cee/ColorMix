package edu.nju.excalibur.colormix.model;

import java.util.ArrayList;

public class QuestionFactory {
	public static Question createQuestionWithCardCount(int cardCount) {
		ArrayList<Card> cardList = new ArrayList<Card>();
		for (int i = 0 ; i < cardCount; i++) {
			Card randomCard = CardFactory.createCard();
			cardList.add(randomCard);
		}
		Question question = new Question(cardList);
		return question;
	}
	
}
