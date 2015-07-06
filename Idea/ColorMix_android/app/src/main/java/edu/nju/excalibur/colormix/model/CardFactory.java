package edu.nju.excalibur.colormix.model;

import java.util.ArrayList;

public class CardFactory {
	public static Card createCard() {
		ArrayList<Color> colorList = new ArrayList<Color>();
		while (colorList.size() < 3) {
			Color color = ColorFactory.getRandomColor();
			boolean has = false;
			for (int i = 0 ; i < colorList.size(); i++) {
				Color currentColor = colorList.get(i);
				if (currentColor.colorId == color.colorId) {
					has = true;
					break;
				}
			}
			if (has == false) {
				colorList.add(color);
			}
		}
		Card card = new Card(colorList);
		return card;
	}
}
