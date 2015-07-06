package edu.nju.excalibur.colormix;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.TextPaint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.LinearInterpolator;
import android.view.animation.TranslateAnimation;
import android.widget.TextView;

import edu.nju.excalibur.colormix.model.Card;
import edu.nju.excalibur.colormix.model.Question;

public class GameFragment extends Fragment {
	public int gameMode;
	public Question question;
	public View root;
	private View cardView;
	private TextView questionTextView;
	private TextView cardTextView;
	private View timeLineView;

	
	
	private int[] option_ids = { R.id.option1, R.id.option2, R.id.option3 };
	private int[] option_textIds = {R.id.option1_text,R.id.option2_text,R.id.option3_text};
	private View[] options;
	private TextView[] optionTextViews;
	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle saveInstanceState) {
		root = inflater.inflate(R.layout.fragment_game_question, null);
		init(root);
		return root;
	}

	private void init(View rootView) {
		options = new View[3];
		optionTextViews = new TextView[3];
		for (int i = 0; i < option_ids.length; i++) {
			options[i] = rootView.findViewById(option_ids[i]);
			options[i].setOnClickListener(listener);
			optionTextViews[i] = (TextView)rootView.findViewById(option_textIds[i]);
			optionTextViews[i].setTypeface(CustomFont.getBondfont(getActivity().getApplicationContext()));
		}
		cardView = rootView.findViewById(R.id.question_card_view);
		cardTextView = (TextView) rootView.findViewById(R.id.question_card_text);
		cardTextView.setTypeface(CustomFont.getBondfont(getActivity().getApplicationContext()));

		questionTextView = (TextView) rootView.findViewById(R.id.questionTextView);
		questionTextView.setTypeface(CustomFont.getBondfont(getActivity().getApplicationContext()));

		timeLineView = rootView.findViewById(R.id.question_time_line_view);

		if (gameMode==0) {
			Card card = question.cardList.get(0);
			cardView.setBackgroundColor(card.backgroundColor.colorId);
			cardTextView.setTextColor(card.textColor.colorId);
			TextPaint paint = cardTextView.getPaint();
			paint.setFakeBoldText(true);
			cardTextView.setText(card.textMeaningColor.colorName);
			if (card.backgroundColor.colorName.equals("BLACK")){
				timeLineView.setBackgroundColor(0x98ffffff);
			} else {
				timeLineView.setBackgroundColor(0x68000000);
			}
			if (card.backgroundColor.colorName.equals("WHITE")||card.backgroundColor.colorName.equals("YELLOW")) {
				questionTextView.setTextColor(0xff000000);
			} else {
				questionTextView.setTextColor(0xffffffff);
			}


		} else {
			cardTextView.setTextSize(60);
			cardTextView.setTextColor(0xffffffff);
			cardTextView.setText("#"+(question.targetCardIndex + 1));
			cardView.setBackgroundColor(0xdd000000);
			questionTextView.setTextColor(0xffffffff);
			timeLineView.setBackgroundColor(0x98ffffff);
		}
		for (int i = 0 ; i < 3; i++) {
			View option = options[i];
			option.setBackgroundColor(question.options.get(i).colorId);
			if (question.options.get(i).colorName.equals("WHITE")){
				optionTextViews[i].setTextColor(0xff000000);
			} else {
				optionTextViews[i].setTextColor(0xffffffff);
			}
		}
		questionTextView.setText(question.getQuestion());
		startTimer();
	}

	public void startTimer() {
		int width = getActivity().getWindowManager().getDefaultDisplay().getWidth();
		Animation translateAnimation = new TranslateAnimation(0, - width, timeLineView.getY(), timeLineView.getY());
		translateAnimation.setDuration((long) (question.limitTime * 1000));
		translateAnimation.setInterpolator(new LinearInterpolator());
		translateAnimation.setAnimationListener(new AnimationListener() {
			@Override
			public void onAnimationStart(Animation animation) {
				// TODO 自动生成的方法存根
			}
			@Override
			public void onAnimationRepeat(Animation animation) {
				// TODO 自动生成的方法存根	
			}
			@Override
			public void onAnimationEnd(Animation animation) {
				timeLineView.setVisibility(View.INVISIBLE);
				GameActivity activity = (GameActivity)getActivity();
				activity.fail();
			}
		});
		timeLineView.startAnimation(translateAnimation);	
	}
	private OnClickListener listener = new OnClickListener() {
		@Override
		public void onClick(View v) {
			int id = v.getId();
			for (int i = 0; i < options.length; i++) {
				if (option_ids[i] == id) {
					GameActivity activity = (GameActivity)getActivity();
					if (question.checkAnswer(i) == true) {
						activity.change();
					} else{
						activity.fail();
					}
				}
			}
		}
	};

}
