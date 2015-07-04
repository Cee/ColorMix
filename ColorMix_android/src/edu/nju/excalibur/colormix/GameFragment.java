package edu.nju.excalibur.colormix;

import java.lang.ref.WeakReference;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.TextPaint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
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
	private View[] options;
	
	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle saveInstanceState) {
		root = inflater.inflate(R.layout.fragment_game_question, null);
		init(root);
		return root;
	}

	private void init(View rootView) {
		options = new View[3];
		for (int i = 0; i < option_ids.length; i++) {
			options[i] = rootView.findViewById(option_ids[i]);
			options[i].setOnClickListener(listener);
		}
		cardView = rootView.findViewById(R.id.question_card_view);
		cardTextView = (TextView) rootView.findViewById(R.id.question_card_text);
		questionTextView = (TextView) rootView.findViewById(R.id.questionTextView);
		timeLineView = rootView.findViewById(R.id.question_time_line_view);
		
		if (gameMode==0) {
			Card card = question.cardList.get(0);
			cardView.setBackgroundColor(card.backgroundColor.colorId);
			cardTextView.setTextColor(card.textColor.colorId);
			TextPaint paint = cardTextView.getPaint();
			paint.setFakeBoldText(true);
			cardTextView.setText(card.textMeaningColor.colorName);
			if (card.backgroundColor.colorName.equals("BLACK")){
				timeLineView.setBackgroundColor(0x88ffffff);				
			}
			if (card.backgroundColor.colorName.equals("WHITE")||card.backgroundColor.colorName.equals("YELLOW")){
				questionTextView.setTextColor(0xffffffff);
			}
		} else {
			cardTextView.setTextColor(0xffffffff);
			cardTextView.setText("#"+(question.targetCardIndex+1));
			cardView.setBackgroundColor(0xdd000000);
			timeLineView.setBackgroundColor(0x88ffffff);
		}
		for (int i = 0 ; i < 3; i++) {
			View option = options[i];
			option.setBackgroundColor(question.options.get(i).colorId);
		}
		questionTextView.setText(question.getQuestion());
		startTimer();
	}

	public void startTimer() {
		int width = getActivity().getWindowManager().getDefaultDisplay().getWidth();
		Animation translateAnimation = new TranslateAnimation(0, - width, timeLineView.getY(), timeLineView.getY());
		translateAnimation.setDuration((long) (question.limitTime * 1000));
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
				NextQuestionInterface callback = callbackRef.get();
				callback.fail();
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
					NextQuestionInterface callback = callbackRef.get();
					if (callback != null) {
						if (question.checkAnswer(i) == true) {
							callback.nextPage();
						} else {
							callback.fail();
						}
					}
				}
			}
		}
	};

	private WeakReference<NextQuestionInterface> callbackRef;

	public void setOnNextQuestionInterface(NextQuestionInterface callback) {
		callbackRef = new WeakReference<NextQuestionInterface>(callback);
	}

	public interface NextQuestionInterface {
		public void nextPage();
		public void fail();
	}

}
