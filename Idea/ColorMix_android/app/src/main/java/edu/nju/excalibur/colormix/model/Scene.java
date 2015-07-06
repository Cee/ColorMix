package edu.nju.excalibur.colormix.model;

public class Scene {
	public int point;
	public Question currentQuestion;
	public Question nextQuestion;
	public int currentMode;

	public Scene(int gameMode){
		this.currentMode = gameMode;
		this.point = 0;
		this.currentQuestion = QuestionFactory.createQuestionWithCardCount(1);
		this.nextQuestion = QuestionFactory.createQuestionWithCardCount(1);
		this.currentQuestion.limitTime = getLimitTime();
		
	}
	
	public void showNextQuestion() {
		point++;
		currentQuestion = nextQuestion;
		currentQuestion.limitTime = getLimitTime();
		int cardCount = 1;
		if (currentMode == 1) {
			if (point > 25) {
				cardCount = 3;
			} else if (point > 10) {
				cardCount = 2;
			}
		}
		nextQuestion = QuestionFactory.createQuestionWithCardCount(cardCount);
	}
	
	private float getLimitTime() {
		float limitTime = (float) (6.0 - this.point * 0.05);
		return (float) (limitTime > 1.6 ? limitTime : 1.6);
	}
}
