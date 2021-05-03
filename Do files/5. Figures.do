		
															 *FIGURES*
	*________________________________________________________________________________________________________________________________*

	
	*Visual Inspection
	*--------------------------------------------------------------------------------------------------------------------------------*
		use "$final/Child Labor Data.dta" if urban == 1 & male == 1 & year == 1999 & xw >= - 12 & xw < 12, clear	

			foreach v of varlist $shortterm_outcomes {
				local `v'_label: var label `v'
			}
			collapse $shortterm_outcomes [pw = weight], by(xw)
			foreach v of varlist $shortterm_outcomes {
				replace   `v' = `v'*100
				label var `v' `"``v'_label'"'
			}

			foreach var of varlist $shortterm_outcomes {
				tw  (lpolyci `var' xw if xw >= 0, degree(0) bw(1) acolor(gs12) fcolor(gs12) clcolor(gray) clwidth(0.3)) 		///
					(lpolyci `var' xw if xw <  0, degree(0) bw(1) acolor(gs12) fcolor(gs12) clcolor(gray) clwidth(0.3)) 		///
					(scatter `var' xw if xw >= -12 & xw <  0 , sort msymbol(circle) msize(small) mcolor(navy))         		 	///
					(scatter `var' xw if xw >=   0 & xw <= 12, sort msymbol(circle) msize(small) mcolor(cranberry)), xline(0) 	///
					legend(off) 																								///
					title({bf:`: variable label `var''}, pos(11) span size(large))												///
					ytitle("%") xtitle("Age difference from the cutoff (in months)") 											/// 
					note("Source: PNAD 1999. 95% CI.", color(black) fcolor(background) pos(7) size(small)) saving(short_`var'.gph, replace) 
			}
			
			graph combine short_eap.gph short_pwork.gph short_uwork.gph short_schoolatt.gph, graphregion(fcolor(white)) ysize(5) xsize(7) title(, fcolor(white) size(medium) color(cranberry))
			graph export "$figures/RDD_shortterm outcomes.pdf", as(pdf) replace
			foreach var of varlist $shortterm_outcomes {
			erase short_`var'.gph
			}	
			
	*Figure 1a/1b
	*--------------------------------------------------------------------------------------------------------------------------------*
		use "$final/Child Labor Data.dta" if urban == 1 & year == 1999 & xw >= - 9 & xw < 0, clear	
			collapse (mean) 		uwork pwork schoolatt pwork_sch uwork_sch pwork_only uwork_only study_only nemnem [pw = weight], by(male)
		
			foreach var of varlist 	uwork pwork schoolatt pwork_sch uwork_sch pwork_only uwork_only study_only nemnem {
				replace `var' = `var'*100
				format 	`var' %12.2fc
				rename  `var' A_`var'
			}
		
			reshape long A_, i(male) 	 j(variable) string
			reshape wide A_, i(variable) j(male)
			
			gen 	ordem = 1  if variable == "uwork"
			replace ordem = 2  if variable == "pwork"
			replace ordem = 3  if variable == "schoolatt"
			replace ordem = 4  if variable == "pwork_sch"
			replace ordem = 5  if variable == "uwork_sch"
			replace ordem = 6  if variable == "pwork_only"
			replace ordem = 7  if variable == "uwork_only"
			replace ordem = 8  if variable == "study_only"
			replace ordem = 9  if variable == "nemnem"
			//unpaid work, unpaid work and school attendance
			graph bar (asis)A_0 A_1 if ordem == 1 | ordem == 2 | ordem == 3, bargap(5) bar(2,  lw(0.5) lcolor(navy) fcolor(gs12)) bar(1, lw(0.5) lcolor(emidblue) fcolor(gs12) fintensity(70))			///
			over(ordem, sort(ordem) label(labsize(small))relabel(1 `"Unpaid work"'  2 `"Paid work"' 3 `""School" "Attendance""'))																		///
			blabel(bar, position(outside) orientation(horizontal) size(medsmall) color(black) format (%4.1fc))   																						///
			title("", pos(12) size(medsmall) color(black)) subtitle(, pos(12) size(medsmall) color(black)) 																								///
			ytitle("%", size(medsmall)) 																																								///
			yscale(off)	 																																												///
			legend(order(1 "Girls" 2 "Boys")  region(lwidth(none) color(white) fcolor(none)) cols(2) size(large) position(12))      		            												///
			note("Source: PNAD 1999." , color(black) fcolor(background) pos(7) size(small)) 																											///
			xsize(6) ysize(5) 
			local nb =`.Graph.plotregion1.barlabels.arrnels'
			di `nb'
			forval i = 1/`nb' {
			  di "`.Graph.plotregion1.barlabels[`i'].text[1]'"
			  .Graph.plotregion1.barlabels[`i'].text[1]="`.Graph.plotregion1.barlabels[`i'].text[1]'%"
			}
			.Graph.drawgraph
			graph export "$figures/Figure1a.pdf", as(pdf) replace
			//working and studying, only working or only studying
			graph bar (asis)A_0 A_1 if ordem > 3 & ordem < 10 , bargap(5) bar(2,  lw(0.5) lcolor(navy) fcolor(gs12)) bar(1, lw(0.5) lcolor(emidblue) fcolor(gs12) fintensity(70))			///
			over(ordem, sort(A_1) label(labsize(small)) relabel(1 `" "Paid work" "and study  "' 2 `" "Unpaid work"  "and study" "'  3 `" "Only" "paid work"   "'  4 `"  "Only" "unpaid work"  "'  5 `" "Only" "study"  "'  6 `" "Neither working" "or studying" "'  ) )																					///
			blabel(bar, position(outside) orientation(horizontal) size(medsmall) color(black) format (%4.1fc))   																			///
			title("", pos(12) size(medsmall) color(black)) subtitle(, pos(12) size(medsmall) color(black)) 																					///
			yscale(off)	 																																									///		
			ytitle("%", size(medsmall)) 																																					///
			legend(order(1 "Girls" 2 "Boys")  region(lwidth(none) color(white) fcolor(none)) cols(2) size(large) position(12))      		            									///
			note("Source: PNAD 1999." , color(black) fcolor(background) pos(7) size(small)) 																								///	
			xsize(6) ysize(5) 
			local nb =`.Graph.plotregion1.barlabels.arrnels'
			forval i = 1/`nb' {
			.Graph.plotregion1.barlabels[`i'].text[1]="`.Graph.plotregion1.barlabels[`i'].text[1]'%"
			}
			.Graph.drawgraph
			graph export "$figures/Figure1b.pdf", as(pdf) replace
			
			
			
	*Figure 2a/2b
	*--------------------------------------------------------------------------------------------------------------------------------*
		use "$final/Child Labor Data.dta" if year >= 1998 & year <= 2006 & urban == 1 & male == 1 & xw >= - 9 & xw <= 0, clear	
			collapse (mean)pwork uwork schoolatt [pw = weight], by(year)
		
			foreach var of varlist pwork uwork schoolatt {
				replace `var' = `var'*100
				format 	`var' %12.1fc
			}
	
			tw 	///
				(line pwork year, msize(1) lwidth(1) color(emidblue)  lp(shortdash) connect(direct) recast(connected) mlabel(pwork) mlabcolor(black) mlabpos(12))   		///  
				(line uwork year, msize(1) lwidth(1) color(cranberry) lp(shortdash) connect(direct) recast(connected) mlabel(uwork) mlabcolor(black) mlabpos(12)) 		 	///  
				(line schoolatt year , msize(1) lwidth(1) color(green*0.8)   lp(shortdash) connect(direct) recast(connected) mlabel(schoolatt) mlabcolor(black) mlabpos(12) ///
				ylabel(, labsize(small) angle(horizontal) format(%2.1fc)) 																									///
				yscale(off) 																																				/// 
				xlabel(1998 `" "1998" "Age-13" "' 1999 `" "1999" "Age-14" "' 2001 `" "2001" "Age-16" "' 2002 `" "2002" "Age-17" "' 2003 `" "2003" "Age-18" "' 2004 `" "2004" "Age-19" "' 2005 `" "2005" "Age-20" "' 2006 `" "2006" "Age-21" "', labsize(small) gmax angle(horizontal)) 											///
				ytitle("%", size(medsmall)) xtitle("") 			 																											///
				legend(order(1 "Paid work" 2 "Unpaid work" 3 "School attendance") pos(12) region(lstyle(none) fcolor(none)) size(medsmall))  								///
				note("Source: PNAD.", span color(black) fcolor(background) pos(7) size(small))) 
				graph export "$figures/Figure2a.pdf", as(pdf) replace
				
				
		use "$final/Child Labor Data.dta" if year >= 1998 & year <= 2006 & urban == 1 & male == 1 & xw > 0 & xw <= 9, clear	
			collapse (mean)pwork uwork schoolatt [pw = weight], by(year)
		
			foreach var of varlist pwork uwork schoolatt {
				replace `var' = `var'*100
				format 	`var' %12.1fc
			}
	
			tw 	///
				(line pwork year, msize(1) lwidth(1) color(emidblue)  lp(shortdash) connect(direct) recast(connected) mlabel(pwork) mlabcolor(black) mlabpos(12))   		///  
				(line uwork year, msize(1) lwidth(1) color(cranberry) lp(shortdash) connect(direct) recast(connected) mlabel(uwork) mlabcolor(black) mlabpos(12)) 		 	///  
				(line schoolatt year , msize(1) lwidth(1) color(green*0.8)   lp(shortdash) connect(direct) recast(connected) mlabel(schoolatt) mlabcolor(black) mlabpos(12) ///
				ylabel(, labsize(small) angle(horizontal) format(%2.1fc)) 																									///
				yscale(off) 																																				/// 
				xlabel(1998 `" "1998" "Age-13" "' 1999 `" "1999" "Age-14" "' 2001 `" "2001" "Age-16" "' 2002 `" "2002" "Age-17" "' 2003 `" "2003" "Age-18" "' 2004 `" "2004" "Age-19" "' 2005 `" "2005" "Age-20" "' 2006 `" "2006" "Age-21" "', labsize(small) gmax angle(horizontal)) 											///
				ytitle("%", size(medsmall)) xtitle("") 			 																											///
				legend(order(1 "Paid work" 2 "Unpaid work" 3 "School attendance") pos(12) region(lstyle(none) fcolor(none)) size(medsmall))  								///
				note("Source: PNAD.", span color(black) fcolor(background) pos(7) size(small))) 
				graph export "$figures/Figure2b.pdf", as(pdf) replace	
				

			
			
			
			
			
			
			
			
			