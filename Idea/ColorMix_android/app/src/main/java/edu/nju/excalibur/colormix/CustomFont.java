package edu.nju.excalibur.colormix;

import android.content.Context;
import android.graphics.Typeface;

/**
 * Created by Xc on 2015/7/6.
 */
public class CustomFont {
    public static Typeface bondFont;
    public static Typeface italicFont;
    public static Typeface getBondfont(Context context){
        if (bondFont == null) {
            bondFont = Typeface.createFromAsset(context.getAssets(), "font/AvenirNextLTPro-Bold.ttf");
        }
        return bondFont;
    }

    public static Typeface getItalicFont(Context context){
        if(italicFont == null) {
            italicFont = Typeface.createFromAsset(context.getAssets(), "font/AvenirNextLTPro-BoldCnIt.ttf");
        }
        return italicFont;
    }
}
