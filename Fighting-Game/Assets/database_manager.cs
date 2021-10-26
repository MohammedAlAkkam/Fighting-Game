using UnityEngine;

public  class database_manager
{
     static bool HasKey(string keyname)
    {
        return PlayerPrefs.HasKey(keyname);
    }

    public static float Getvolume()
    {
        return HasKey("sound") ? PlayerPrefs.GetFloat("sound") : 1;
    }
    public static void Setvolume(float value)
    {
        PlayerPrefs.SetFloat("sound",value);
        PlayerPrefs.Save();

    }
    public static bool GetSword(int id)
    {
        string x;
        if (HasKey("Sowrd"))
        {
            PlayerPrefs.SetString("Sword", "1");
            PlayerPrefs.Save();
        }
        x = PlayerPrefs.GetString("Sword");
        Debug.Log(x);
        return PlayerPrefs.GetString("Sword").Contains(id.ToString());

    }
    public static void SetSword(int id)
    {
        PlayerPrefs.SetString("Sword", PlayerPrefs.GetString("Sword") + id.ToString());
        PlayerPrefs.Save();


    }


    public static bool GetShield(int id)
    {
        string x;
        if (HasKey("Shield"))
        {
            PlayerPrefs.SetString("Shield", "1");
            PlayerPrefs.Save();

        }
        x = PlayerPrefs.GetString("Shield");
        return PlayerPrefs.GetString("Shield").Contains(id.ToString());

    }
    public static void SetShield(int id)
    {
        PlayerPrefs.SetString("Shield", PlayerPrefs.GetString("Shield") + id.ToString());
        PlayerPrefs.Save();

    }


    public static bool Getcharacter(int id)
    {
        string x;
        if (HasKey("Character"))
        {
            PlayerPrefs.SetString("Character", "1");
            PlayerPrefs.Save();

        }
        x = PlayerPrefs.GetString("Character");

        return x.Contains(id.ToString());

    }
    public static void Setcharacter(int id)
    {
        PlayerPrefs.SetString("Character", PlayerPrefs.GetString("Character") + id.ToString());
        PlayerPrefs.Save();

    }
}
