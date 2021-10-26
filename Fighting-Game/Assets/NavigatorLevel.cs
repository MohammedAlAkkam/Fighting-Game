using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
public class NavigatorLevel : MonoBehaviour
{
    public GameObject Setting;
    public enum Navigator
    {
        Start,
        Setting,
        Shopping,
        Levels,
        Exit
    }
    [SerializeField] Navigator navigator;
    private void Start()
    {
        GetComponent<Button>().onClick.AddListener(button);
    }
    public void button()
    {
        
        switch (navigator)
        {
            case Navigator.Start:
                
                break;
            case  Navigator.Setting:
                Setting.SetActive(true);

                break;
            case  Navigator.Shopping:
                SceneManager.LoadScene("shopping");
                SceneManager.SetActiveScene(SceneManager.GetSceneByName("shopping"));

                break;
            case Navigator.Levels:
                SceneManager.LoadScene("Level0" + Player.character.Level);
               // SceneManager.SetActiveScene(SceneManager.GetSceneByName("livels"));
                break;
            case Navigator.Exit:
                Application.Quit();
                break;
            default:
                break;
        }
        
    }
}
