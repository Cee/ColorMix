package edu.nju.excalibur.colormix;

import java.io.File;

import com.umeng.analytics.AnalyticsConfig;
import com.umeng.analytics.game.UMGameAgent;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.ActivityInfo;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

public class MainMenuActivity extends Activity {
	SettingFragment settingFragment; 
	GameResultFragment gameResultFragment;
	TutorialFragment tutorialFragment;
	private int tutorialIndex = 0;
	private int gameMode;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
		UMGameAgent.setDebugMode(true);//设置输出运行时日志
		UMGameAgent.init(this);
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        setContentView(R.layout.activity_main_menu);
    }
    
    @Override
	protected void onResume() {
		super.onResume();
		UMGameAgent.onResume(this);
	     SharedPreferences sharedPreferences = getSharedPreferences("localdata", Context.MODE_PRIVATE);
	     int score = sharedPreferences.getInt("score", -1);
	     if (score>=0) {
	    	 gameResultFragment = new GameResultFragment();
	    	 int highest = sharedPreferences.getInt("highest", -1);
    		 Editor editor = sharedPreferences.edit();
    		 editor.putInt("score", -1);
	    	 if (highest < score) {
	    		 highest = score;
	    		 editor.putInt("highest", highest);
	    	 }
    		 editor.commit();
	    	 gameResultFragment.highest = highest;
	    	 gameResultFragment.score = score;
	 		getFragmentManager().beginTransaction().replace(R.id.setting_fragment, gameResultFragment).commit();
	    }
	}
    
    @Override
	protected void onPause() {
		super.onPause();
		UMGameAgent.onPause(this);
	}

	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    
	public void goToFantasyMode(View v) {
		gameMode = 1;
		Intent intent = new Intent(MainMenuActivity.this,GameActivity.class);
		intent.putExtra("mode", 1);
		startActivity(intent);
	}
	
	
	public void goToClassicMode(View v) {
		gameMode = 0;
		Intent intent = new Intent(MainMenuActivity.this,GameActivity.class);
		intent.putExtra("mode", 0);
		startActivity(intent);
	}
	
	public void goToSetting(View v) {
		settingFragment = new SettingFragment();
		getFragmentManager().beginTransaction().replace(R.id.setting_fragment, settingFragment).commit();
	}
	
	
	
	public void home(View v){
		FragmentTransaction fragmentTransaction = getFragmentManager().beginTransaction();
        fragmentTransaction.remove(gameResultFragment);
        fragmentTransaction.addToBackStack(null);
        fragmentTransaction.commit();
	}
	
	public void dismiss(View v) {
		FragmentTransaction fragmentTransaction = getFragmentManager().beginTransaction();
        fragmentTransaction.remove(settingFragment);
        fragmentTransaction.addToBackStack(null);
        fragmentTransaction.commit();
	}
	
	public void replay(View v){
		if (gameMode == 0) {
			goToClassicMode(null);
		} else {
			goToFantasyMode(null);
		}
	}

	public void rate(View v){
		Uri url = Uri.parse("http://colormix.cee.moe");
		Intent intent = new Intent(Intent.ACTION_VIEW, url);
		startActivity(intent);
	}
	public void shareScore(View v){
		String mode;
		if (gameMode==0){
			mode = "classic";
		} else {
			mode = "fantasy";
		}
		shareMsg("Share", "share the score", "I scored "+gameResultFragment.score+" in the "+mode+" mode, play #Co!orMix with me: colormix.cee.moe", null);		
	}
	
	public void share(View v) {
		shareMsg("Share", "分享应用", "Think you know color? Come and play Co!orMix, a game about color and your reflection. And Please be nice to your phone.  colormix.cee.moe ", null);
	}
	
	/** 
     * 分享功能 
     *  
     * @param context 
     *            上下文 
     * @param activityTitle 
     *            Activity的名字 
     * @param msgTitle 
     *            消息标题 
     * @param msgText 
     *            消息内容 
     * @param imgPath 
     *            图片路径，不分享图片则传null 
     */  
    public void shareMsg(String activityTitle, String msgTitle, String msgText,  
            String imgPath) {  
        Intent intent = new Intent(Intent.ACTION_SEND);  
        if (imgPath == null || imgPath.equals("")) {  
            intent.setType("text/plain"); // 纯文本  
        } else {  
            File f = new File(imgPath);  
            if (f != null && f.exists() && f.isFile()) {  
                intent.setType("image/jpg");  
                Uri u = Uri.fromFile(f);  
                intent.putExtra(Intent.EXTRA_STREAM, u);  
            }  
        }  
        intent.putExtra(Intent.EXTRA_SUBJECT, msgTitle);  
        intent.putExtra(Intent.EXTRA_TEXT, msgText);  
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);  
        startActivity(Intent.createChooser(intent, activityTitle));  
    }
    
    
    public void tutorial(View v){
    	tutorialFragment = new TutorialFragment();    	
    	getFragmentManager().beginTransaction().replace(R.id.setting_fragment, tutorialFragment).commit();
    }
    
    public void nextImg(View v){
    	tutorialIndex++;
    	if (tutorialIndex < 8)
    		tutorialFragment.tutorialImageView.setImageResource(tutorialFragment.images[tutorialIndex]);
    	else {
    		FragmentTransaction fragmentTransaction = getFragmentManager().beginTransaction();
            fragmentTransaction.remove(tutorialFragment);
            fragmentTransaction.addToBackStack(null);
            fragmentTransaction.commit();
    	}
    }
}
