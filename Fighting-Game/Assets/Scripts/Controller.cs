using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Controller : MonoBehaviour
{
    public bool  CanDamage = false;
    public bool IsAttack;
    public string DamageTag;
    public bool shield;
    public bool IsDathe;
    public Animator animator;
    public CharacterController controller;


    public void DamageState()
    {
        CanDamage = !CanDamage;
    }


}
