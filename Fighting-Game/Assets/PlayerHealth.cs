using UnityEngine;
using UnityEngine.UI;
public class PlayerHealth : MonoBehaviour
{
    // Start is called before the first frame update
    Damage damage;
    void Start()
    {
       damage  = GameObject.FindGameObjectWithTag("Player").GetComponent<Damage>(); 
    }

    // Update is called once per frame
    void Update()
    {
        transform.localScale = new Vector3(damage.Current_Health/100,0,0);
    }
}
