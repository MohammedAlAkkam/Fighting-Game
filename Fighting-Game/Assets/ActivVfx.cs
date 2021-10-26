using UnityEngine;

public class ActivVfx : MonoBehaviour
{
     GameObject player;
    
    void LateUpdate()
    {
        if (!player) return;
        transform.position = player.transform.position;
        transform.rotation = player.transform.rotation;
    }
    public void SetPlayer(GameObject Player)
    {
        player = Player;
    }
}
