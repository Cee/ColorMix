package edu.nju.excalibur.colormix.model;

import java.util.ArrayList;
import java.util.Collections;

enum Element{
	background,
	textColor,
	meaning
}
public class Card {
	public Color backgroundColor;
	public Color textColor;
	public Color textMeaningColor;
	private ArrayList<Color> colorList;
	public Card(ArrayList<Color> colorList){
		this.colorList = colorList;
		this.backgroundColor = colorList.get(0);
		this.textColor = colorList.get(1);
		this.textMeaningColor = colorList.get(2);
	}
	
	public ArrayList<Color> generateOptions() {
		Collections.shuffle(this.colorList);
		 return this.colorList;
	}
	
	public int getAnswerByOption(ArrayList<Color> options, Element element) {
		Color targetColor = null;
		switch (element) {
		case background:
			targetColor = backgroundColor;
			break;
		case textColor:
			targetColor = textColor;
			break;
		case meaning:
			targetColor = textMeaningColor;
			break;
		default:
			break;
		}
		int index = 0;
		for (index = 0 ; index < options.size() ; index++) {
			Color color = options.get(index);
			if (targetColor.colorId == color.colorId) {
				return index;
			}
		}
		return index;
	}
}
