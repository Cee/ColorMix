package edu.nju.excalibur.colormix.model;


public class ColorFactory {
	public static int[] colorIds = {0xffffffff,0xff44db5e,0xff9b59b6,0xffff99ac,0xffff9600,0xffffee24,0xff54c7fc,0xff6a4320,0xffff220c,0xff000000};
	public static String[] colorNames = {"WHITE","GREEN","PURPLE","PINK","ORANGE","YELLOW","BLUE","BROWN","RED","BLACK"};
	public static Color getRandomColor(){
		int index = ((int) (Math.random()*1000)) % colorIds.length;
		Color color = new Color(colorIds[index],colorNames[index]);
		return color;
	}
	
	public static Color getRandomColorExcept(String colorName){
		Color color = getRandomColor();
		while (!color.colorName.equals(colorName)) {
			color = getRandomColor();
		}
		return color;
	}
}
