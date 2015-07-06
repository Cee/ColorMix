package edu.nju.excalibur.colormix;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

public class TutorialFragment extends Fragment {
	public ImageView tutorialImageView;
	public int start;
	public int[] images = {R.drawable.classic_tutorial1,R.drawable.classic_tutorial2,R.drawable.classic_tutorial3,R.drawable.classic_tutorial4
			,R.drawable.fantasy_tutorial1,R.drawable.fantasy_tutorial2,R.drawable.fantasy_tutorial3,R.drawable.fantasy_tutorial4};
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_tutorial,container,false);
		tutorialImageView = (ImageView) rootView.findViewById(R.id.tutoral_image);
		tutorialImageView.setImageResource(images[start]);
		return rootView;
	}

}
