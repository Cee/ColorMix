package edu.nju.excalibur.colormix;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.ArrayList;
import edu.nju.excalibur.colormix.model.Card;
import edu.nju.excalibur.colormix.model.Scene;

public class GameActivity extends FragmentActivity {
	private GameFragment currentQuestionFragment;
	private GameFragment nextQuestionFragment;
	private TutorialFragment tutorialFragment;
	private ArrayList<CardFragment> cardViewList;
	private TextView scoreTextView;
	private Handler handler;
	private Scene scene;
	public int gameMode;
	public int tutorialIndex;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
		gameMode = getIntent().getIntExtra("mode", 0);
		setContentView(R.layout.activity_game);
		scoreTextView = (TextView) findViewById(R.id.score_text_view);
		scoreTextView.setText("0");
		scoreTextView.setTypeface(CustomFont.getItalicFont(getApplicationContext()));
		init();
	}
	
	public void nextImg(View v){
		tutorialIndex ++;
		if (tutorialIndex - tutorialFragment.start <=3) {
    		tutorialFragment.tutorialImageView.setImageResource(tutorialFragment.images[tutorialIndex]);
		} else {
			init();
		}
	}
	
	private void init() {
	    SharedPreferences sharedPreferences = getSharedPreferences("localdata", Context.MODE_PRIVATE);
	    if (gameMode == 0) {
	    	if (sharedPreferences.getBoolean("first_classic", true)){
	        	tutorialFragment = new TutorialFragment();    	
	        	getFragmentManager().beginTransaction().replace(R.id.FrameLayout1, tutorialFragment).commit();
	        	Editor editer = sharedPreferences.edit();
	        	editer.putBoolean("first_classic", false);
	        	editer.commit();
	        	return;
	    	} 
	    }
	    if (gameMode == 1) {
	     	if (sharedPreferences.getBoolean("first_fantasy", true)){
	        	tutorialFragment = new TutorialFragment(); 
	        	tutorialIndex = 4;
	        	tutorialFragment.start = 4;
	        	getFragmentManager().beginTransaction().replace(R.id.FrameLayout1, tutorialFragment).commit();
	        	Editor editer = sharedPreferences.edit();
	        	editer.putBoolean("first_fantasy", false);
	        	editer.commit();
	        	return;
	    	} 
	    }
		scene = new Scene(gameMode);
		FragmentManager manager = getSupportFragmentManager();
		FragmentTransaction transaction = manager.beginTransaction();
		currentQuestionFragment = new GameFragment();
		currentQuestionFragment.gameMode = gameMode;
		currentQuestionFragment.question = scene.currentQuestion;
		nextQuestionFragment = new GameFragment();
		nextQuestionFragment.gameMode = gameMode;
		nextQuestionFragment.question = scene.nextQuestion;
		if (gameMode==1){
			cardViewList = new ArrayList<CardFragment>();
			ArrayList<Card> cardList = scene.currentQuestion.cardList;
			for (int i = 0 ; i < cardList.size(); i++){
				CardFragment cardFragment = new CardFragment();
				cardFragment.card = cardList.get(i);
				cardViewList.add(cardFragment);
			}
			transaction.replace(R.id.FrameLayout1, cardViewList.get(0));
			transaction.commit();
			handler = new Handler() {
				public void handleMessage(Message msg){
					FragmentManager manager = getSupportFragmentManager();
					FragmentTransaction transaction = manager.beginTransaction();
					int index = msg.what;
					transaction.setCustomAnimations(R.anim.essense_right_in,R.anim.essense_left_out,
							R.anim.essense_right_in,R.anim.essense_left_out);
					if (index == 0) {

						transaction.replace(R.id.FrameLayout1, currentQuestionFragment);
					} else {
						transaction.replace(R.id.FrameLayout1, cardViewList.get(index));
					}
					transaction.commit(); 
				}
			};
			new Thread(new MyThread()).start();
		} else {
			transaction.replace(R.id.FrameLayout1, currentQuestionFragment);
			transaction.commit();
		}
		if (currentQuestionFragment.question.cardList.get(0).backgroundColor.colorName.equals("WHITE")) {
			scoreTextView.setTextColor(0xff000000);
		} else {
			scoreTextView.setTextColor(0xffffffff);
		}
	}
	
	public class MyThread implements Runnable {

		@Override
		public void run() {
			for (int i = 1 ; i < cardViewList.size(); i++){
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				Message message   = new Message();
				message.what = i;
				handler.sendMessage(message);
			}
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			Message message   = new Message();
			message.what = 0;
			handler.sendMessage(message);
		}
	}

	public void fail(){
		SharedPreferences sharedPreferences = getSharedPreferences("localdata", Context.MODE_PRIVATE);
		Editor editor = sharedPreferences.edit();
		editor.putInt("score", scene.point);
		editor.commit();
		Log.v("test","..............fail"+scene.point);
		finish();
	}

	public void change() {
		currentQuestionFragment = nextQuestionFragment;
		scene.showNextQuestion();
		nextQuestionFragment = new GameFragment();
		nextQuestionFragment.gameMode = gameMode;
		nextQuestionFragment.question = scene.nextQuestion;
		scoreTextView.setText(""+scene.point);
		if (currentQuestionFragment.question.cardList.get(0).backgroundColor.colorName.equals("WHITE")) {
			scoreTextView.setTextColor(0xff000000);
		} else {
			scoreTextView.setTextColor(0xffffffff);
		}
		FragmentManager manager = getSupportFragmentManager();
		FragmentTransaction transaction = manager.beginTransaction();
		transaction.setCustomAnimations(R.anim.essense_right_in,R.anim.essense_left_out,
				R.anim.essense_right_in,R.anim.essense_left_out);
		if (gameMode==0){
			transaction.replace(R.id.FrameLayout1, currentQuestionFragment);
			transaction.commit();
		} else {
			cardViewList = new ArrayList<CardFragment>();
			ArrayList<Card> cardList = scene.currentQuestion.cardList;
			for (int i = 0 ; i < cardList.size(); i++){
				CardFragment cardFragment = new CardFragment();
				cardFragment.card = cardList.get(i);
				cardViewList.add(cardFragment);
			}
			transaction.replace(R.id.FrameLayout1, cardViewList.get(0));
			transaction.commit();
			new Thread(new MyThread()).start();
		}	
	}
}
