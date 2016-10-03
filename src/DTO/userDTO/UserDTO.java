package DTO.userDTO;

public class UserDTO {
	public int user_id = -1;//初始化为-1,方便在更新数据的时候判断是否需要更新数据
	public String user_name;
	public String user_pass ;
	public int user_phone = -1;//初始化为-1,方便在更新数据的时候判断是否需要更新数据
	public String user_email ;
	public String user_photo ;
	public String user_summary;
}
