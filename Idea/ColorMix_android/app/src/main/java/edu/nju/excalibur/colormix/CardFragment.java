package edu.nju.excalibur.colormix;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import edu.nju.excalibur.colormix.model.Card;

public class CardFragment extends Fragment {
	public View root;
	private TextView textView;
	public Card card;
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle saveInstanceState) {
		root = inflater.inflate(R.layout.fragment_game_card, null);
		init(root);
		return root;
	}
	public void init(View root){
		textView = (TextView) root.findViewById(R.id.card_text_view);
		root.setBackgroundColor(card.backgroundColor.colorId);
		textView.setText(card.textMeaningColor.colorName);
		textView.setTextColor(card.textColor.colorId);
	}
}
