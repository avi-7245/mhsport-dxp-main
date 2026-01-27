<#assign preferences = freeMarkerPortletPreferences.getPreferences("portletSetupPortletDecoratorId", "barebone") />
<#assign profileImageURL = user.getPortraitURL(themeDisplay)> 

<div class="top-header"> 
	<div class="align-items-center d-flex gov-logo">
		<img src="/documents/d/guest/indian-national-removebg-preview-1" alt="" title="" />
		<h5 class="m-0 text-white company-text">
			<span>
<@liferay.language key="directorate-of-sports-and-youth-services" />
</span>
			<br/>
			<small><@liferay.language key="government-of-maharashtra" /></small>
		</h5>
	</div>
	
	<div class="reg-links">
		<ul class="list-inline mb-0">
			<li class="search-bar-new list-inline-item mr-3"> 
				<div class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> 
					<i class="bi bi-search searchDrop"></i>
				</div>  
	 
				<div class="dropdown-menu dropdown-menu-right shadow border-0 rounded-0 p-0" style="width: 250px;border-radius: 50px !important;"> 
					<@liferay_portlet["runtime"]
						defaultPreferences="${preferences}"
						portletName="com_liferay_portal_search_web_search_bar_portlet_SearchBarPortlet"
					/>       
				</div>				 
			</li>
		
		
			<li class="list-inline-item mr-3">
									<@liferay_portlet["runtime"]

     				portletProviderAction=portletProviderAction.VIEW

     				portletProviderClassName="com.liferay.portal.kernel.servlet.taglib.ui.LanguageEntry"

     				instanceId="sports_search"

 />

			</li>
			
			<#if is_signed_in>
				<li class="list-inline-item">
					<div class="profile dropdown signed-profile">
						<div class="userProfile dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> 
							<h6 class="mx-2 mt-2 text-white">${user_name}</h6>
						</div>  
	 
					<div class="dropdown-menu dropdown-menu-right shadow border-0 rounded-0 animate__animated animate__fadeIn p-0"> 
						<a href="/group/guest/profile" class="text-decoration-none dropdown-item p-3">
		  					<span class="icon">
		  						<i class="bi bi-person"></i>
		  					</span>
		 					<@liferay.language key="my-profile" />
	  					</a> 
	  
	  					<a href="/group/guest/dashboard" class="text-decoration-none dropdown-item p-3">
		  					<span class="icon">
								<i class="bi bi-ui-checks-grid"></i>
		  					</span>
		  					<@liferay.language key="dashboard" />
	  					</a> 
	  
						<a href="/c/portal/logout" class="text-decoration-none dropdown-item p-3">
		  					<span class="icon">
								<i class="bi bi-door-open"></i>
		  					</span>
		  					<@liferay.language key="log-out" />
	  					</a>              
					</div> 
				</div>
				</li>
			<#else>
				<li class="list-inline-item mob-hide">
					<a href="/login" class="text-decoration-none text-white">
            			<i class="bi bi-box-arrow-in-left"></i> <@liferay.language key="login" />
            		</a>
				</li>
			
				<li class="list-inline-item mob-hide">
					<a href="/registration" class="text-decoration-none text-white">
				 		<i class="bi bi-person"></i> <@liferay.language key="registration" />
				 	</a>
				</li>
			</#if>
		</ul>
	</div>
</div>
  
<#include "${full_templates_path}/navigation.ftl" /> 
  
<#--Mobile Navigation-->
<div class="mobileNavigaiton p-3 bg-white">
  	<div class="align-items-center d-flex justify-content-between">
	  <div class="mobile-logo">
		  <a href="/">
		    <img alt="logo" src="${site_logo}" class="white-logo">              
		  </a>
	  </div>
	  
	  <div class="mNavbar">
	  	<#include "${full_templates_path}/navigation.ftl" />
	  </div> 
  </div>   	
</div>
<#--Mobile Navigation--> 
<style>
.bhashini-plugin-container svg path {
    fill: #ffffff !important;
}
.bhashini-plugin-container>.bhashini-dropdown {
top: 10px!important;
}
.bhashini-dropdown-btn-icon {
margin-top: -17px!important;
}
</style>
