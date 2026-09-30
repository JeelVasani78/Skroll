<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="f_profile.aspx.vb" Inherits="tybca21_project_sem_v.f_profile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skroll</title>
    <link rel="stylesheet" href="profile.css" />
    <link rel="shortcut icon" type="x-icon" href="./images/nav_logo3.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>
   <div class="main">
    <form id="Form1" name="frm1" runat="server">
        <!-- Sidebar -->
        <div class="left">
            <div class="left_top">
                <div class="sidebar_logo_holder"></div>
            </div>
            <div class="left_middle">
                
                    <asp:ScriptManager ID="sm1" runat="server">
                    </asp:ScriptManager>

                    <asp:UpdatePanel ID="up1" runat="server">

                        <ContentTemplate>

                            <asp:Panel ID="s_p1" runat="server" CssClass="s_btn_holder">
                                <i class="fa-solid fa-house"></i>
                                <asp:Label ID="s_l1" runat="server" Text="Home"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p2" runat="server" CssClass="s_btn_holder search_btn" onclick="search_toggle()">
                                <i class="fa-solid fa-magnifying-glass" id="search_i"></i>
                                <asp:Label ID="s_l2" runat="server" Text="Search"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p3" runat="server" CssClass="s_btn_holder">
                                <i class="fa-regular fa-compass"></i>
                                <asp:Label ID="s_l3" runat="server" Text="Explore"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p4" runat="server" CssClass="s_btn_holder">
                                <i class="fa-solid fa-film"></i>
                                <asp:Label ID="s_l4" runat="server" Text="Reels"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p5" runat="server" CssClass="s_btn_holder">
                                <i class="fa-brands fa-facebook-messenger"></i>
                                <asp:Label ID="s_l5" runat="server" Text="Message"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p6" runat="server" CssClass="s_btn_holder noti_btn" onclick="noti_toggle()">
                                <i class="fa-regular fa-heart">
                                    <asp:Label ID="red_dot" runat="server" CssClass="red_dot_hidden"></asp:Label>
                                </i>
                                <asp:Label ID="s_l6" runat="server" Text="Notification"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p7" runat="server" CssClass="s_btn_holder">
                                <i class="fa-regular fa-square-plus"></i>
                                <asp:Label ID="s_l7" runat="server" Text="Create"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p8" runat="server" CssClass="s_btn_holder s_selected">
                                <div class="sidebar_p_img">
                                    <asp:Image ID="sidebar_p_img" runat="server" cssClass="image_holder"/>
                                </div>
                                <asp:Label ID="s_l8" runat="server" Text="Profile"></asp:Label>
                            </asp:Panel>

                    </ContentTemplate>

                </asp:UpdatePanel>

            </div>
            
            <div class="left_bottom">
                <div class="s_btn_holder more_btn" tabindex="-1">
                    <i class="fa-solid fa-bars"></i>
                    <p>More</p>
                    
                </div>
            </div>
            <div class="more_content" tabindex="-1">
                <div class="s_btn_holder" onclick="theme_toggle()">
                    <i class="fa-regular fa-moon"></i>
                    <p>Appearance</p>
                </div>
                <div class="s_btn_holder lo_div">
                    <i class="fa-solid fa-person-through-window"></i>
                    <p>Logout</p>
                    <asp:Button ID="logout_btn" runat="server" style="display:none;" />
                </div>
            </div>
            
        </div>
        <!-- End Sidebar -->

        <!-- Right -->
        <div class="right">
            
            <div class="right_top">
                <div class="r_top_left">
                    <div class="user_img_holder">
                        <asp:Image ID="user_img_holder" runat="server" CssClass="image_holder" />
                    </div>
                </div>
                
                <div class="r_top_right">
                
                    <div class="r_t_right_p1">
                    <asp:Label ID="user_name" runat="server" CssClass="user_name"></asp:Label>
                    <asp:UpdatePanel ID="user_info_up1" runat="server">
                    <ContentTemplate>
                    <asp:Button ID="follow_btn" runat="server" Text="Follow" CssClass="follow_btn" />
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>

                    <div class="r_t_right_p2">
                    <asp:Label ID="post_count" runat="server" Text="0 posts"></asp:Label>
                    <asp:Label ID="followers_count" runat="server" Text=" followers" CssClass="f_lbl"></asp:Label>
                    <asp:Label ID="following_count" runat="server" Text=" following" CssClass="f_lbl"></asp:Label>
                    </div>

                    <div class="r_t_right_p3">
                    <asp:Label ID="full_name" runat="server"></asp:Label>
                    <asp:Label ID="gen_display" runat="server" CssClass="gen_display"></asp:Label>
                    </div>

                    <div class="r_t_right_p4">
                    <asp:TextBox ID="bio" runat="server" TextMode="MultiLine" CssClass="bio" ReadOnly="True"></asp:TextBox>
                    </div>
                
                </div>
                
            </div>
            <div class="right_bottom">
                <div class="r_b_top">
                    <div class="r_b_top_child1 r_b_top_active">
                        <i class="ri-image-circle-fill"></i>
                        <asp:Label ID="u_posts" runat="server" Text="Photos"></asp:Label>
                    </div>
                    <div class="r_b_top_child2">
                        <i class="ri-play-circle-line"></i>
                        <asp:Label ID="u_videos" runat="server" Text="Videos"></asp:Label>
                    </div>
                </div>

                <!-- Photo Post -->
                <asp:Panel ID="r_b_bottom_img" runat="server" CssClass="r_b_bottom_img">
                <asp:Repeater ID="p_r1" runat="server">
                <ItemTemplate>
                    <asp:UpdatePanel ID="post_up1" runat="server">
                    <ContentTemplate>
                        <asp:LinkButton ID="p_img_holder" runat="server" CssClass="p_img_holder">
                            <asp:Image ID="p_img" runat="server" ImageUrl='<%# Eval("p_img") %>' CssClass="image_holder"/>
                            <asp:Label ID="p_id1" runat="server" style="display:none" Text='<%# Eval("p_id") %>'></asp:Label>
                            <asp:Panel ID="like_cmt_holder1" runat="server" CssClass="like_cmt_holder">
                                <div class="l_c_ico_lbl_1">
                                    <i class="fa-regular fa-heart"></i>
                                    <asp:Label ID="img_likes" runat="server" Text='<%# Eval("like_count") %>'></asp:Label>
                                </div>
                                <div class="l_c_ico_lbl_2">
                                    <i class="ri-chat-3-line"></i>
                                    <asp:Label ID="img_cmt" runat="server" Text='<%# Eval("cmt_count") %>'></asp:Label>
                                </div>
                            </asp:Panel>
                         </asp:LinkButton>
                         
                    </ContentTemplate>
                    <Triggers>
                        
                        <asp:PostBackTrigger ControlID="p_img_holder" />
                    </Triggers>
                    </asp:UpdatePanel>
                </ItemTemplate>
                </asp:Repeater>
                </asp:Panel>
                <!-- End Photo Post --> 


                <!-- Video Post -->
                <asp:Panel ID="r_b_bottom_vid" runat="server" CssClass="r_b_bottom_vid">
                <asp:Repeater ID="p_r2" runat="server">
                <ItemTemplate>
                    <asp:UpdatePanel ID="post_up2" runat="server">
                    <ContentTemplate>

                    <asp:LinkButton ID="p_vid_holder" runat="server" CssClass="p_vid_holder">
                        <asp:Panel ID="like_cmt_holder2" runat="server" CssClass="like_cmt_holder">
                            <div class="l_c_ico_lbl_1">
                                <i class="fa-regular fa-heart"></i>
                                <asp:Label ID="vid_likes" runat="server" Text='<%# Eval("like_count") %>'></asp:Label>
                            </div>
                            <div class="l_c_ico_lbl_2">
                                <i class="ri-chat-3-line"></i>
                                <asp:Label ID="vid_cmt" runat="server" Text='<%# Eval("cmt_count") %>'></asp:Label>
                            </div>
                        </asp:Panel>
                        <asp:Literal ID="p_vid" runat="server" Text='<%# Eval("html_vid") %>'></asp:Literal>
                        <asp:Label ID="p_id2" runat="server" style="display:none" Text='<%# Eval("p_id") %>'></asp:Label>   
                        
                    </asp:LinkButton>

                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="p_vid_holder" />
                    </Triggers>
                    </asp:UpdatePanel>
                                
                </ItemTemplate>
                </asp:Repeater>
                </asp:Panel>
                <!-- End Video Post -->
            </div>

            <!-- Follower Panel -->
            <div class="followers_panel">
                <div class="followers_top">
                    Followers
                    <i class="fa-solid fa-xmark" id="f_close1"></i>
                </div>
                <asp:UpdatePanel ID="f_up1" runat="server">
                <ContentTemplate>
                <asp:Panel ID="followers_bottom" runat="server" CssClass="followers_bottom">
                    <asp:Repeater ID="f1_r1" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="f_info_holder1" runat="server" CssClass="f_info_holder" CommandArgument='<%# Eval("user_id") %>'>
                            <asp:Image ID="f_img_holder1" runat="server" CssClass="f_img_holder" ImageUrl='<%# Eval("user_p") %>'/>
                            <asp:Label ID="f_unm1" runat="server" CssClass="f_unm" Text='<%# Eval("user_nm") %>'></asp:Label>
                            <asp:Label ID="f_user_id1" runat="server" Text='<%# Eval("user_id") %>' style="display:none;"></asp:Label>
                        </asp:LinkButton>
                    </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>
                </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <!-- End Follower Panel -->

            <!-- Following Panel -->
            <div class="following_panel">
                <div class="following_top">
                    Following
                    <i class="fa-solid fa-xmark" id="f_close2"></i>
                </div>
                <asp:UpdatePanel ID="f_up2" runat="server">
                <ContentTemplate>
                <asp:Panel ID="following_bottom" runat="server" CssClass="following_bottom">
                    <asp:Repeater ID="f2_r1" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="f_info_holder2" runat="server" CssClass="f_info_holder" CommandArgument='<%# Eval("user_id") %>'>
                            <asp:Image ID="f_img_holder2" runat="server" CssClass="f_img_holder" ImageUrl='<%# Eval("user_p") %>'/>
                            <asp:Label ID="f_unm2" runat="server" CssClass="f_unm" Text='<%# Eval("user_nm") %>'></asp:Label>
                            <asp:Label ID="f_user_id2" runat="server" Text='<%# Eval("user_id") %>' style="display:none;"></asp:Label>
                        </asp:LinkButton>
                    </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>
                </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <!-- End Following Panel -->

            <!--Edit User Profile-->
            <div class="edit_user_profile">
                
            </div>
            <!-- End Edit User Profile-->
            <!-- About User -->

            <div class="about_user" tabindex="-1">
                <asp:Image ID="a_user_img" runat="server" CssClass="a_user_img"/>
                <asp:Label ID="a_usernm" runat="server"></asp:Label>
                <asp:Label ID="a_user_f_nm" runat="server"></asp:Label>
                <asp:Label ID="a_u_joined_date" runat="server"></asp:Label>
            </div>

            <!-- End About User -->

        </div>

        <!-- End Right -->
            <!--<asp:Label ID="test_lbl" runat="server" ForeColor="red" CssClass="test_lbl" BackColor="white" Text="testinggg"></asp:Label>-->
        <!-- Search -->

        <div class="search_panel">

            <div class="search_top">
                <h2>Search</h2>
                <i class="fa-solid fa-xmark" id="search_cancel"></i>
            </div>

            <div class="search_bottom">
                <asp:Panel ID="search_p1" runat="server">

                    <asp:UpdatePanel ID="search_up1" runat="server">
                    
                        <ContentTemplate>
                            <asp:Panel ID="search_bar" runat="server" class="search_bar">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                <asp:TextBox ID="search_input" runat="server" placeholder="Search" CssClass="search_input" AutoPostBack="true"></asp:TextBox>
                                
                            </asp:Panel>
                            <asp:Panel ID="search_result" runat="server" Visible="false" CssClass="search_result">
                                <asp:Repeater ID="search_r1" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="search_id" runat="server" CssClass="s_btn_holder" CommandArgument='<%# Eval("user_id") %>'>
                                        <div class="sidebar_p_img">
                                            <asp:Image ID="search_profile" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                                        </div>
                                        <asp:Label ID="search_usernm" runat="server" Text='<%# Eval("user_nm") %>'></asp:Label>
                                        <asp:Label ID="s_f_user_id" runat="server" Text='<%# Eval("user_id") %>' style="display:none;"></asp:Label>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                </asp:Repeater>
                            </asp:Panel>
                          
                        </ContentTemplate>
                       
                    </asp:UpdatePanel>
                </asp:Panel>
            </div>
        </div>

        <!-- End Search -->

        <!-- Notification -->

        <div class="noti_panel">
        
            <div class="noti_top">
                <h2>Notification</h2>
                <i class="fa-solid fa-xmark" id="noti_cancel"></i>
            </div>
            <div class="noti_bottom">
                <asp:UpdatePanel ID="noti_up1" runat="server">
                    <ContentTemplate>

                        <asp:Panel ID="noti_result" runat="server" CssClass="noti_result">
                            <asp:Repeater ID="noti_r1" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="noti_info_holder" runat="server" CssClass="noti_info_holder">
                                        <div class="noti_u_img">
                                            <asp:Image ID="noti_u_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                                        </div>
                                        <div class="noti_u_info">
                                            <asp:Label ID="noti_unm" runat="server" CssClass="s_selected" Text='<%# Eval("user_nm") %>'></asp:Label>
                                            <asp:Label ID="noti_msg" runat="server" Text="started following you"></asp:Label>
                                        </div>
                                        <!--<asp:Button ID="noti_f_btn" runat="server" CssClass="noti_f_btn" Text="Follow"/>-->
                                        <asp:Label ID="noti_uid" runat="server" style="display:none" Text='<%# Eval("user_id") %>'></asp:Label>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
                
        </div>

        <!-- End Notification -->

        <!-- User's Post -->
        
        <asp:Panel ID="post_panel" runat="server" CssClass="post_panel_closed">
            <div class="u_post_img_holder">
                <asp:Literal ID="post_literal" runat="server"></asp:Literal>
                <asp:Label ID="post_id" runat="server" style="display:none"></asp:Label>
            </div>
            <div class="u_post_info_holder">
                <div class="u_p_i_top">
                    <div class="u_p_info">
                        <div class="u_p_img_holder">
                            <asp:Image ID="u_p_img" runat="server" CssClass="image_holder" />
                        </div>
                        <asp:Label ID="u_p_nm" runat="server"></asp:Label>
                        
                    </div>
                    <i class="fa-solid fa-xmark" id="close_post"></i>
                </div>
                <div class="u_p_i_middle">
                    <asp:Panel ID="post_desc" runat="server" CssClass="post_desc" Visible="false">
                        <asp:LinkButton ID="cmt_user_info" runat="server" CssClass="cmt_user_info">
                            <div class="cmt_user_img_holder">
                                <asp:Image ID="cmt_user_img" runat="server" CssClass="image_holder" />
                            </div>
                            <asp:Label ID="cmt_user_nm" runat="server"></asp:Label>
                            <asp:Label ID="cmt_user_id" runat="server" style="display:none"></asp:Label>
                        </asp:LinkButton>
                        <asp:TextBox ID="user_cmt" runat="server" Rows="2" TextMode="MultiLine" CssClass="user_cmt" ReadOnly="true"></asp:TextBox>
                    </asp:Panel>

                    <asp:Repeater ID="cmt_r1" runat="server">
                    <ItemTemplate>
                    <asp:Panel ID="cmt_section" runat="server" CssClass="post_desc">
                        <asp:LinkButton ID="o_cmt_user_info" runat="server" CssClass="cmt_user_info">
                            <div class="cmt_user_img_holder">
                                <asp:Image ID="o_cmt_user_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                            </div>
                            <asp:Label ID="o_cmt_user_nm" runat="server" Text='<%# Eval("user_nm") %>'></asp:Label>
                            <asp:Label ID="o_cmt_user_id" runat="server" style="display:none" Text='<%# Eval("user_id") %>'></asp:Label>
                        </asp:LinkButton>
                        <asp:TextBox ID="o_user_cmt" runat="server" Text='<%# Eval("cmt") %>' Rows="2" TextMode="MultiLine" CssClass="user_cmt" ReadOnly="true"></asp:TextBox>
                    </asp:Panel>
                    </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="u_p_i_bottom">
                    <div class="u_p_i_b1">
                        
                            <asp:LinkButton ID="like_icon" runat="server" Cssclass="like_icon_outlined">
                                <i class="fa-regular fa-heart" id="outlined_heart"></i>
                                <i class="fa-solid fa-heart" id="filled_heart"></i>
                                <asp:HiddenField ID="like_status" runat="server" />
                            </asp:LinkButton>
                        
                    </div>
                    <div class="u_p_i_b2">
                        <span class="see_likes_option">See Likes</span>
                    </div>
                    <div class="u_p_i_b3">
                        <asp:TextBox ID="cmt_txtbox" runat="server" CssClass="cmt_txtbox" TextMode="MultiLine" placeholder="Add a comment" onkeyup="enable_cmt_btn()"></asp:TextBox>
                        <asp:Button ID="cmt_post_btn" runat="server" CssClass="cmt_post_btn" Text="Post"  Enabled="false" ForeColor="#484848"/> 
                    </div>
                </div>
            </div>

            
        </asp:Panel>
        
        <!-- End User's Post -->
        </form>
    </div>

    <!-- Script -->
    
    <script type="text/javascript">
        if (window.history.replaceState) 
        {
            window.history.replaceState(null, null, window.location.href);
        }
        function attachEventListeners()
        {
            var sidebar_logo=document.querySelector(".sidebar_logo_holder").addEventListener("click",function(){location.reload();});
            var h_btn=document.querySelector("#s_p1").addEventListener("click",function(){window.location.href="user_dashboard.aspx";});
            var ex_btn=document.querySelector("#s_p3").addEventListener("click",function(){window.location.href="explore.aspx";});
            var reels_btn=document.querySelector("#s_p4").addEventListener("click",function(){window.location.href="reels.aspx";});
            var msg_profile_btn=document.querySelector("#s_p5").addEventListener("click",function(){window.location.href="message.aspx";});
            var create_btn=document.querySelector("#s_p7").addEventListener("click",function(){window.location.href="create.aspx";});
            var u_profile_btn=document.querySelector("#s_p8").addEventListener("click",function(){window.location.href="u_profile.aspx";});
        
        }
        
        document.addEventListener("DOMContentLoaded", function () {
            attachEventListeners();
            set_photos_videos_position();
            like_icon_toggle();
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            attachEventListeners();
            
        });

        /* More Toggle */
        var more_content=document.querySelector(".more_content");
        var more_btn=document.querySelector(".more_btn");

        more_btn.addEventListener("focus", function () {
            more_content.style.bottom = "0";
            more_content.style.zIndex = "5";
            more_content.style.opacity = "1";
            setTimeout(function () { more_content.focus(); }, 500);

        });
        more_content.addEventListener("blur", function () {
            more_content.style.bottom = "-20px";
            more_content.style.zIndex = "-1";
            more_content.style.opacity = "0";
        });
        /* End More Toggle */

        /* Searchbar Toggle */
        
        var search_btn=document.querySelector(".search_btn");
        var search_panel=document.querySelector(".search_panel");
        var search_cancel=document.querySelector("#search_cancel");

        function search_toggle(){
            if(search_panel.style.left=="250px")
            {
                search_panel.style.left="-60px";
            }
            else
            {
                search_panel.style.left="250px";
                noti_panel.style.left="-60px";
            }     
        }
        search_cancel.addEventListener("click",function(){
            if(search_panel.style.left=="250px")
            {
                search_panel.style.left="-60px";
            }
            else
            {
                search_panel.style.left="250px";
            }     
        });
        
        /* End Searchbar Toggle */

        /* Notification Toggle*/

        var noti_btn=document.querySelector(".noti_btn");
        var noti_panel=document.querySelector(".noti_panel");
        var noti_cancel=document.querySelector("#noti_cancel");
        var red_dot=document.querySelector("#red_dot");

        function noti_toggle(){
            if(noti_panel.style.left=="250px")
            {
                noti_panel.style.left="-60px";
            }
            else
            {
                noti_panel.style.left="250px";
                search_panel.style.left="-60px";
                red_dot.className="red_dot_hidden"
            }     
        }
        noti_cancel.addEventListener("click",function(){
            if(noti_panel.style.left=="250px")
            {
                noti_panel.style.left="-60px";
            }
            else
            {
                noti_panel.style.left="250px";
            }     
        });

        /* End Notificaton Toggle*/

        /* Theme */
        var main = document.querySelector(".main");
        var left = document.querySelector(".left");
        var right = document.querySelector(".right");

        //var main_bg = window.getComputedStyle(main).backgroundColor;
        //var main_bg=main.style.background;
        
        function theme_toggle() 
        {
            var main_bg = window.getComputedStyle(main).backgroundColor;

            //console.log("hello");
            //console.log(main_bg);

            if (main_bg === 'rgb(255, 255, 255)') 
            {
                main.style.backgroundColor = 'black';
                left.style.backgroundColor = 'black';
                right.style.backgroundColor = 'black';
                const allElements = document.querySelectorAll("*");
                allElements.forEach(element => {element.style.color = "#f1f1f1";});
            } 
            else 
            {
                main.style.backgroundColor = 'white';
                left.style.backgroundColor = 'white';
                right.style.backgroundColor = 'white';
                const allElements = document.querySelectorAll("*");
                allElements.forEach(element => {element.style.color = "black";});
            }
        }
        /* End Theme */

        /* logout */

        var lo_div=document.querySelector(".lo_div").addEventListener("click",function(){
            var logout_btn=document.querySelector("#logout_btn").click();
        });

        /* End logout */



        /* Post-Video Toggle */

        var post_lb=document.querySelector(".r_b_top_child1");
        var vid_lb=document.querySelector(".r_b_top_child2");

        var post_img=document.querySelector(".r_b_bottom_img");
        var post_vid=document.querySelector(".r_b_bottom_vid");


        post_lb.addEventListener("click",function(){
            post_img.style.zIndex="1";
            post_img.style.display="grid";

            post_vid.style.zIndex="-1";
            post_vid.style.display="none";

            post_lb.classList.add("r_b_top_active");
            vid_lb.classList.remove("r_b_top_active");

            localStorage.setItem("p_img_zindex","1");
            localStorage.setItem("p_img_display","grid");

            localStorage.setItem("p_vid_zindex","-1");
            localStorage.setItem("p_vid_display","none");
        });
        vid_lb.addEventListener("click",function(){
            post_img.style.zIndex="-1";
            post_img.style.display="none";

            post_vid.style.zIndex="1";
            post_vid.style.display="grid";

            post_lb.classList.remove("r_b_top_active");
            vid_lb.classList.add("r_b_top_active");

            localStorage.setItem("p_img_zindex","-1");
            localStorage.setItem("p_img_display","none");

            localStorage.setItem("p_vid_zindex","1");
            localStorage.setItem("p_vid_display","grid");

            
        });

        function set_photos_videos_position(){
            const p_img_zindex=localStorage.getItem("p_img_zindex");
            const p_img_display=localStorage.getItem("p_img_display");

            const p_vid_zindex=localStorage.getItem("p_vid_zindex");
            const p_vid_display=localStorage.getItem("p_vid_display");

            post_img.style.zIndex=p_img_zindex;
            post_img.style.display=p_img_display;

            post_vid.style.zIndex=p_vid_zindex;
            post_vid.style.display=p_vid_display;

            if(p_img_zindex=="1")
            {
                post_lb.classList.add("r_b_top_active");
                vid_lb.classList.remove("r_b_top_active");
            }
            else
            {
                post_lb.classList.remove("r_b_top_active");
                vid_lb.classList.add("r_b_top_active");
            }
        }


        /* End Post-Video Toggle */


        /* Followers panel toggle */

        var f1_count=document.querySelector("#followers_count");
        var f1_panel=document.querySelector(".followers_panel");
        f1_count.addEventListener("click",function(){
            
            if(f1_panel.style.opacity=="1")
            {
                f1_panel.style.opacity="0";
                f1_panel.style.zIndex="-1";
                f1_panel.style.transform="scale(0.5)";

            }
            else
            {
                f1_panel.style.opacity="1";
                f1_panel.style.zIndex="5";
                f1_panel.style.transform="scale(1)";

                f2_panel.style.opacity="0";
                f2_panel.style.zIndex="-1";
                f2_panel.style.transform="scale(0.5)";

                about_user.style.opacity="0";
                about_user.style.zIndex="-1";
                about_user.style.transform="scale(0.5)";

                edit_user.style.opacity="0";
                edit_user.style.zIndex="-1";
                edit_user.style.transform="scale(0.5)";
            }
        });

 

        var f2_count=document.querySelector("#following_count");
        var f2_panel=document.querySelector(".following_panel");
        f2_count.addEventListener("click",function(){
            
            if(f2_panel.style.opacity=="1")
            {
                f2_panel.style.opacity="0";
                f2_panel.style.zIndex="-1";
                f2_panel.style.transform="scale(0.5)";
            }
            else
            {
                f2_panel.style.opacity="1";
                f2_panel.style.zIndex="5";
                f2_panel.style.transform="scale(1)";

                f1_panel.style.opacity="0";
                f1_panel.style.zIndex="-1";
                f1_panel.style.transform="scale(0.5)";

                about_user.style.opacity="0";
                about_user.style.zIndex="-1";
                about_user.style.transform="scale(0.5)";

                edit_user.style.opacity="0";
                edit_user.style.zIndex="-1";
                edit_user.style.transform="scale(0.5)";
            }
        });

        var f_close1=document.querySelector("#f_close1").addEventListener("click",function(){
                f1_panel.style.opacity="0";
                f1_panel.style.zIndex="-1";
                f1_panel.style.transform="scale(0.5)";     
        });
        var f_close2=document.querySelector("#f_close2").addEventListener("click",function(){
                f2_panel.style.opacity="0";
                f2_panel.style.zIndex="-1";
                f2_panel.style.transform="scale(0.5)";     
        });
        /* End Followers panel toggle */

        /* About User */

        var about_user=document.querySelector(".about_user");
        var user_name=document.querySelector(".user_name").addEventListener("click",function(){
            if(about_user.style.opacity=="1")
            {
                about_user.style.opacity="0";
                about_user.style.zIndex="-1";
                about_user.style.transform="scale(0.5)";   
            }
            else
            {
                about_user.style.opacity="1";
                about_user.style.zIndex="5";
                about_user.style.transform="scale(1)";  
                about_user.focus();

                f1_panel.style.opacity="0";
                f1_panel.style.zIndex="-1";
                f1_panel.style.transform="scale(0.5)";

                f2_panel.style.opacity="0";
                f2_panel.style.zIndex="-1";
                f2_panel.style.transform="scale(0.5)"; 
                
                edit_user.style.opacity="0";
                edit_user.style.zIndex="-1";
                edit_user.style.transform="scale(0.5)";    
            }
        });

        about_user.addEventListener("blur",function(){
            about_user.style.opacity="0";
            about_user.style.zIndex="-1";
            about_user.style.transform="scale(0.5)";   
        });

        /* End About User */

        

        /* Close User Post */

        var close_u_post=document.querySelector("#close_post").addEventListener("click",function(){
            var post_panel=document.querySelector(".post_panel_opened");
                post_panel.className="post_panel_closed";
        });

        /* End Close User Post */
        

        /* Like Icon Toggle */

        var o_heart=document.querySelector("#outlined_heart");
        var f_heart=document.querySelector("#filled_heart");
        var l_icon=document.getElementById('<%= like_icon.ClientID %>');
        var like_status=document.getElementById('<%= like_status.ClientID %>');

        o_heart.addEventListener("click",function(){
            
            l_icon.className="like_icon_filled";
            like_status.value="filled";
                
            o_heart.style.zIndex="-5";
            o_heart.style.opacity="0";

            f_heart.style.zIndex="1";
            f_heart.style.opacity="1";

            localStorage.setItem("l_icon","like_icon_filled");
            localStorage.setItem("like_lbl","filled");

            localStorage.setItem("o_h_zindex","-5");
            localStorage.setItem("o_h_opacity","0");

            localStorage.setItem("f_h_zindex","1");
            localStorage.setItem("f_h_opacity","1");
        });

        f_heart.addEventListener("click",function(){
        
            l_icon.className="like_icon_outlined";
            like_status.value="outlined";

            o_heart.style.zIndex="1";
            o_heart.style.opacity="1";

            f_heart.style.zIndex="-5";
            f_heart.style.opacity="0";
            
            localStorage.setItem("l_icon","like_icon_outlined");
            localStorage.setItem("like_lbl","outlined");

            localStorage.setItem("o_h_zindex","1");
            localStorage.setItem("o_h_opacity","1");

            localStorage.setItem("f_h_zindex","-5");
            localStorage.setItem("f_h_opacity","0");

        });


        function like_icon_toggle()
        {

            var like_icon=localStorage.getItem("l_icon");
            var l_lbl=localStorage.getItem("like_lbl");

            const o_h_zindex=localStorage.getItem("o_h_zindex");
            const o_h_opacity=localStorage.getItem("o_h_opacity");

            const f_h_zindex=localStorage.getItem("f_h_zindex");
            const f_h_opacity=localStorage.getItem("f_h_opacity");
            

            l_icon.className=like_icon;
            like_status.value=l_lbl;

            o_heart.style.zIndex=o_h_zindex;
            o_heart.style.opacity=o_h_opacity;

            f_heart.style.zIndex=f_h_zindex;
            f_heart.style.opacity=f_h_opacity;

        }
        /* End Like Icon Toggle */


        /* Enable-Disable Comment Button */

        function enable_cmt_btn()
        {
            var cmt_textbox = document.getElementById('<%= cmt_txtbox.ClientID %>');
            var cmt_btn = document.getElementById('<%= cmt_post_btn.ClientID %>');

            if (cmt_textbox.value.trim() !== "") 
            {
                cmt_btn.disabled = false;
                cmt_btn.style.color="#0095f6";
            } 
            else 
            {
                cmt_btn.disabled = true;
                cmt_btn.style.color="#484848";
            }
        }

        /* End Enable-Disable Comment Button */


        

    </script>

    <!-- End Script -->
</body>
</html>
