using UnityEngine;

public class Attack : MonoBehaviour
{
    public Controller controller;
    public string DamageTag;
    [SerializeField] float Damageamount = 30;
    void Start()
    {
        controller = GetComponentInParent<Controller>();
        DamageTag = controller.DamageTag;

    }



    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == DamageTag)
        {
            if (controller.CanDamage)
            {

                Damage c = other.GetComponent<Damage>();
                if (!c.controller.shield || c.controller.IsDathe)
                c.TackDamage(Damageamount);
               
                    c.controller.animator.SetTrigger("take_damage");
            }
        }
    }
}
