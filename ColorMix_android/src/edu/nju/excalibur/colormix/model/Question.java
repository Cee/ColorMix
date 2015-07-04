package edu.nju.excalibur.colormix.model;

import java.util.ArrayList;

public class Question {
	public ArrayList<Card> cardList;
	public ArrayList<Color> options;
	public int targetCardIndex = 0;
	public float limitTime = 0;
	private int answerIndex = 0;
	private Element targetElement;
	public Question(ArrayList<Card> cardList) {
		this.cardList = cardList;
		if (this.cardList.size() == 1) {
			this.targetCardIndex = 0;
		} else {
			this.targetCardIndex = ((int) (Math.random()*999)) % this.cardList.size();
		}
		Card targetCard = this.cardList.get(this.targetCardIndex);
		this.options = targetCard.generateOptions();
		int targetElementIndex = ((int) (Math.random()*999)) % 3;
		switch (targetElementIndex) {
		case 0:
			this.targetElement = Element.background;
			break;
		case 1:
			this.targetElement = Element.textColor;
			break;
		case 2:
			this.targetElement = Element.meaning;
			break;
		default:
			break;
		}
		this.answerIndex = targetCard.getAnswerByOption(this.options, targetElement);
	} 
	
	public Boolean checkAnswer(int answerIndex) {
		return answerIndex == this.answerIndex;
	}
	
	public String getQuestion() {
		switch (targetElement) {
		case background:
			return "Background";
		case textColor:
			return "Color";
		case meaning:
			return "Meaning";
		default:
			break;
		}
		return "";
	}
	
}
