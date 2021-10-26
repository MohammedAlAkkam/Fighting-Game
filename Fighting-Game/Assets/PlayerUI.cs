using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerUI : MonoBehaviour
{
    [SerializeField] GameObject weapen;
    [SerializeField] GameObject shieldPos;
    private void Start()
    {
        DontDestroyOnLoad(gameObject);
     
    }
    public void PlayerSetupShield()
    {
        Destroy(shieldPos.transform.GetChild(0).gameObject);
        
        int Shield_Index = PlayerSetup_Manager.manager.Shield_Index;
       // if (Shield_Index == -1) Shield_Index = 0;

        GameObject item  = PlayerSetup_Manager.manager.shields[Shield_Index].model;
        GameObject shield = Instantiate(item);
        shield.transform.parent = (shieldPos.transform);
        shield.transform.localRotation =Quaternion.Euler(Vector3.zero);
        shield.transform.localPosition = Vector3.zero;
        GetComponent<Damage>().ShiledDamageAble =  PlayerSetup_Manager.manager.shields[Shield_Index].damageable;
    }
    public void PlayerSetupSowrd()
    {
        Destroy(weapen.transform.GetChild(0).gameObject);

        int Shield_Index = PlayerSetup_Manager.manager.Sowrd_Index;
        if (Shield_Index == -1) Shield_Index = 0;

        Sword item = PlayerSetup_Manager.manager.swords[Shield_Index];
        GameObject model = item.model;
        int Id = item.ID;
        GameObject sowrd = Instantiate(model);
        sowrd.transform.parent = (weapen.transform);
        sowrd.transform.localRotation = Quaternion.Euler(Vector3.zero);
        sowrd.transform.localPosition = Vector3.zero;
        GetComponent<PlayerController>().SetSword(item);
    }

}
