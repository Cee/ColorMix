package edu.nju.excalibur.colormix;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class GameResultFragment extends Fragment {
	public View root;
	public int score;
	public int highest;
	private TextView scoreTextView;
	private TextView higestTextView;
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle saveInstanceState) {
		root = inflater.inflate(R.layout.activity_main_result, null);
		init(root);
		return root;
	}
	public void init(View root){
		scoreTextView = (TextView) root.findViewById(R.id.result_score);
		higestTextView = (TextView) root.findViewById(R.id.result_highest);
		scoreTextView.setText("Score: "+score);
		higestTextView.setText("Best: "+highest);
		higestTextView.setTypeface(CustomFont.getBondfont(getActivity().getApplicationContext()));
		scoreTextView.setTypeface(CustomFont.getBondfont(getActivity().getApplicationContext()));
	}
}




