<br />
<cfoutput>

   <!---  <!-- Page Header -->
    <!-- Set your background image for this header on the line below. -->
    <header class="intro-header" style="background-image: url('img/home-bg.jpg')">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="site-heading">
                        <h1>Links</h1>
                        <hr class="small">
                        <span class="subheading">
							Opus Group, LLC Links
							&nbsp;&nbsp;
							<cfif isUserInRole("administrator")>
								<button type="button" class="btn btn-success btn-xs" onClick="location.href='#event.buildLink(linkTo = 'link.add', ssl = true)#'; ">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>
							</cfif>
						</span>
                    </div>
                </div>
            </div>
        </div>
    </header> --->

	<!--- <div class="paginator_div">
		#renderPaginator(
			total_records = request.intLinkCount
			, page = url.page
		)#
	</div> --->
</cfoutput>
<table class="table table-striped table-hover table_background">
	<tr>
		<th>Link Image Icon</th>
		<th>Link Name</th>
		<th class="hidden-xs">Link URL</th>
		<th class="visible-md visible-lg">Active</th>
		<th class="visible-md visible-lg">Last Updated</th>
		<th class="visible-lg">Created</th>
		<cfif isUserInRole("administrator")>
			<th style="text-align: right; ">
				<!--- <cfoutput>
					<button type="button" class="btn btn-success btn-xs" onClick="location.href='#event.buildLink(linkTo = 'link.add', ssl = true)#'; ">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</button>
				</cfoutput> --->
				&nbsp;
			</th>
		</cfif>
	</tr>
	<cfoutput>
		<form method="post" name="links_form" id="links_form" action="#event.buildLink(linkTo = 'link.remove', ssl = true)#">
			<input type="hidden" name="link_id" id="link_id" value="" maxlength="50"/>
			<cfif NOT arrayLen(request.aryLinks)>
				<tr>
					<td colspan="#isUserInRole('administrator') ? 7 : 6#">
						<span style="font-size: 18px; ">No links found.</span>
					</td>
				</tr>
			<cfelse>
				<cfset variables.intRowCount = 0/>
				<cfloop array="#request.aryLinks#" index="variables.objLink">
					<cfset variables.intRowCount++/>
					<tr>
						<td>
							<cfif len(trim(variables.objLink.getLink_url_tx()))>
								<a href="#variables.objLink.getLink_url_full_tx()#" target="_blank">
							</cfif>
							<cfif
								len(trim(variables.objLink.getLink_image_file_name_tx()))
								AND fileExists(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & variables.objLink.getLink_image_file_name_tx()))
								AND isImageFile(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & variables.objLink.getLink_image_file_name_tx()))
							>
								<img
									src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & variables.objLink.getLink_image_file_name_tx()#"
									alt="#variables.objLink.getLink_name_tx()# Link Icon Image"
									style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "
								/>
							<cfelse>
								<img
									src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation#_no_link_image_available.png"
									alt="#variables.objLink.getLink_name_tx()# Link Icon Image Placeholder"
									style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "
								/>
							</cfif>
							<cfif len(trim(variables.objLink.getLink_url_tx()))>
								</a>
							</cfif>
						</td>
						<td>
							#len(trim(variables.objLink.getLink_name_tx())) ? variables.objLink.getLink_name_tx() : "&nbsp;"#
						</td>
						<td class="hidden-xs">
							<cfif len(trim(variables.objLink.getLink_url_tx()))>
								<a href="#variables.objLink.getLink_url_full_tx()#" target="_blank">
									#variables.objLink.getLink_url_full_tx()#
								</a>
							<cfelse>
								&nbsp;
							</cfif>
						</td>
						<td class="visible-md visible-lg">#yesNoFormat(variables.objLink.getLink_active_bt())#</td>
						<td class="visible-md visible-lg">#isDate(variables.objLink.getLink_update_datetime_dt()) ? dateTimeFormat(variables.objLink.getLink_update_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
						<td class="visible-lg">#isDate(variables.objLink.getLink_create_datetime_dt()) ? dateTimeFormat(variables.objLink.getLink_create_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
						<cfif isUserInRole("administrator")>
							<td style="text-align: right; white-space: nowrap; ">
								<button type="button" class="btn btn-warning btn-xs" title="Edit Link" onClick="location.href='#event.buildLink(linkTo = 'link.edit.#variables.objLink.getLink_id()#', ssl = true)#'; ">
									<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
								</button>
								<button type="button" class="btn btn-danger btn-xs" title="Delete Link" onClick="linkRemove(#variables.objLink.getLink_id()#)">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
								</button>
							</td>
						</cfif>
					</tr>
				</cfloop>
			</cfif>
		</form>
	</cfoutput>
</table>


