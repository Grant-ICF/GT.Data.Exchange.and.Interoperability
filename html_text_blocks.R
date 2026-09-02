#HTML Messages

HomePage_overview <- HTML("<h2>Welcome!</h2>
              <p><b>The HMIS API Product Suite</b> 
              is an <a href = 'https://github.com/Grant-ICF/GT.Data.Exchange.and.Interoperability/tree/main'
              > open-source</a>
              project developed in collaboration with the Data Exchange and Interoperability Workgroup, which included several HMIS vendors and the Department of Housing and Urban Development (HUD).<p>
              <p> This product suite is intended to support HMIS Vendors and developers 
                          implement data exchange and interoperability processes for 
                          Continuums of Care (CoCs). The intention of this suite of 
                          products is to directly benefit people experiencing homelessness 
                          by reducing the need for duplicative storytelling and 
                          improving access to critical services or support needed 
                          to resolve their housing crisis. It also minimizes the data entry burden on 
                          service providers by reducing duplicative data entry, allowing them to focus 
                          more on delivering care.</p>
                          <p> Please note that HMIS API Reference guide is intended to provide an 
                          overview of each of the components of the HMIS API Product Suite. 
                          The HMIS API Product Suite is a living set of tools for HMIS vendors, developers, and CoCs.<p>
                    
                          
                          ")

HomePage_Overview <-  HTML(
  "<p>The HMIS API Product Suite was developed in collaboration with the 
  Data Exchange and Interoperability Workgroup, which included several HMIS 
  vendors and the Department of Housing and Urban Development (HUD). </p>
              <p>Generate a hashed HMIS CSV Export from your local HMIS and store
              it in a secure location that you can easily find again. It must be
              a .zip file with 23 csv files in it.
              <ul>
              <li>A hashed export means that the personal identifiers are obscured
              when the export is generated.</li>
              <li>The HMIS CSV Export has client-level data in it, so it must be
              stored in a secure location per HUD, state, and local rules and
              regulations.</li>
              <li>If you are unsure how to generate your hashed HMIS CSV Export,
              please contact your vendor.</li>
              </ul>
              
              <p>Once you have exported the correct file from your HMIS, you are
              ready to engage with Eva. Navigate to the \'HMIS CSV Export\' tab
              and follow the instructions there.</p>

              <p>Want to explore Eva without uploading? Use Eva's Demo Mode by clicking the 
              toggle at the top.</p>
              ")