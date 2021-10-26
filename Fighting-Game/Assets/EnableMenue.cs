using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class EnableMenue : MonoBehaviour
{
   public void ChangeMenueStat()
    {
        gameObject.SetActive(!gameObject.activeSelf);
    }
   public void Exitbtn()
    {
        gameObject.SetActive(false);

        Destroy(GameObject.FindGameObjectWithTag("Player"));
        SceneManager.LoadScene("shopping");
    }
}
