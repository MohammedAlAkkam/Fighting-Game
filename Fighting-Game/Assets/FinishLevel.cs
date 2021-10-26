using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class FinishLevel : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == "Player")
        {
            Destroy(other.gameObject);
            SceneManager.LoadScene("shopping");
            Player.character.Level++;
            Player.character.mony = 20000;
        }
    }
}
