using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerSetUo : MonoBehaviour
{
     public GameObject player;
    public bool lighting;
    [SerializeField] Cinemachine.CinemachineFreeLook camer;
    private void Start()
    {
     
        if (Player.character.player)
        {
            player = Player.character.player;
        

        }
        player.transform.position = GameObject.Find("StartPoint").transform.position;
        camer.m_Follow = player.transform.Find("Center");
        camer.m_LookAt = player.transform.Find("Center");
        if (lighting) player.transform.Find("Light").gameObject.SetActive(true);
       MonoBehaviour []components = player.GetComponents<MonoBehaviour>();
       foreach (var item in components)
       {
           item.enabled = true;
       }
        player.GetComponent<PlayerController>().IsDathe = false;
       player.GetComponentInChildren<Attack>().enabled = true;
       
    }
}
