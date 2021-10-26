using UnityEngine;
using UnityEngine.SceneManagement;


public class Damage : MonoBehaviour
{
    public float Current_Health  =  100;
    public GameObject Addhealth;
    public Controller controller;
    public float ShiledDamageAble = 0;
    public float playerDamageAble = 0;
    [SerializeField]GameObject Health_UI;
    Player_Health HealthBar;
    static float KillCount = 0;
    private void OnEnable()
    {
        Current_Health = 100;
        controller = GetComponent<Controller>();
        if (controller is PlayerController)
        {
            transform.position = GameObject.Find("StartPoint").transform.position;

            controller = controller as PlayerController;
            HealthBar =  Instantiate(Health_UI, GameObject.Find("Canvas").transform).GetComponent<Player_Health>();
            

        }
        else if (controller is Enemy_Controller)
        {
            controller = controller as Enemy_Controller;
            HealthBar = Health_UI.GetComponent<Player_Health>();
        }

    }
    private void Update()
    {
       HealthBar.UpdateHealthBar(Current_Health);
    }
    public void TackDamage(float i)
    {
        
        HealthBar.lerptime = 0;
        if(controller is PlayerController)
        Current_Health -= 10;
        if (controller is Enemy_Controller)
            Current_Health -= 30;
        if (Current_Health <=0)Death();
    }
    void Death()
    {
        controller.IsDathe = true;
    controller.animator.SetTrigger("death");
        controller.enabled = false;
        controller.GetComponent<CharacterController>().enabled = false;
        if (controller is PlayerController)
            Invoke("ResetLevel", 3.7f);
        else
        {
            Destroy(gameObject, 2.3f);
            Instantiate(Addhealth, transform.position, Quaternion.identity);
        }
    }
    private void ResetLevel()
    {
        Destroy(gameObject);
        SceneManager.LoadScene("shopping");
        //HealthBar = Instantiate(Health_UI, GameObject.Find("Canvas").transform).GetComponent<Player_Health>();


    }
    public void damageSound()
    {
        FindObjectOfType<SoundManager>().Play("Damage");
    }

}
