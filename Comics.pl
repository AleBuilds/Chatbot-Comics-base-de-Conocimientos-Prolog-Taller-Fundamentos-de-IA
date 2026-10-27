% DC
comic(all_star_superman).
comic(batman_ano_1).
comic(absolute_wonderwoman).
comic(teen_titans_2026).
comic(green_lantern_2026).
comic(dc_ko).
comic(barbara_gordon_breakout).
comic(deathstroke_the_terminator_2026).
comic(superman_2023).
comic(batman_deadpool_2025).

% Marvel
comic(spiderman_noir).
comic(capitan_america_white).
comic(what_if).
comic(wolverine_2024).
comic(inmortal_hulk).
comic(magik_colossus_2026).
comic(x_men_united).
comic(king_in_black).
comic(sorcerer_supreme_2025).
comic(fantastic_four_2025).

% --- 2. HECHOS: ATRIBUTOS DE CADA CÓMIC ---
% Editoriales
%DC
editorial(all_star_superman, dc).
editorial(batman_ano_1, dc).
editorial(absolute_wonderwoman, dc).
editorial(teen_titans_2026, dc).
editorial(green_lantern_2026, dc).
editorial(dc_ko, dc).
editorial(barbara_gordon_breakout, dc).
editorial(deathstroke_the_terminator_2026, dc).
editorial(superman_2023, dc).
editorial(batman_deadpool_2025, dc).

%Marvel
editorial(spiderman_noir, marvel).
editorial(capitan_america_white, marvel).
editorial(what_if, marvel).
editorial(wolverine_2024, marvel).
editorial(inmortal_hulk, marvel).
editorial(magik_colossus_2026, marvel).
editorial(x_men_united, marvel).
editorial(king_in_black, marvel).
editorial(sorcerer_supreme_2025, marvel).
editorial(fantastic_four_2025, marvel).


% Años de publicación
anio_publicacion(all_star_superman, 2005).
anio_publicacion(spiderman_noir, 2008).
anio_publicacion(capitan_america_white, 2015).
anio_publicacion(absolute_wonderwoman, 2024).
anio_publicacion(teen_titans_2026, 2026).
anio_publicacion(green_lantern_2026, 2026).
anio_publicacion(dc_ko, 2025).
anio_publicacion(barbara_gordon_breakout, 2026).
anio_publicacion(deathstroke_the_terminator_2026, 2026).
anio_publicacion(superman_2023, 2023).
anio_publicacion(batman_deadpool_2025, 2025).
anio_publicacion(what_if, 1977).
anio_publicacion(inmortal_hulk, 2026).
anio_publicacion(x_men_united, 2026).
anio_publicacion(king_in_black, 2026).
anio_publicacion(batman_ano_1, 1987).
anio_publicacion(wolverine_2024, 2024).
anio_publicacion(magik_colossus_2026, 2026).
anio_publicacion(sorcerer_supreme_2025, 2025).
anio_publicacion(fantastic_four_2025, 2025).

% Autores (Escritores)
autor(all_star_superman, grant_morrison).
autor(spiderman_noir, david_hine).
autor(capitan_america_white, jeph_loeb).
autor(absolute_wonderwoman, kelly_thompson).
autor(teen_titans_2026, kyle_higgins).
autor(green_lantern_2026, jeremy_adams).
autor(dc_ko, scoott_sneyder).
autor(barbara_gordon_breakout, mariko_tamaki).
autor(deathstroke_the_terminator_2026, tony_fleecs).
autor(superman_2023, joshua_williamson).
autor(batman_deadpool_2025, grant_morrison).
autor(what_if, roy_thomas).
autor(inmortal_hulk, al_ewing).
autor(x_men_united, eve_l_ewing).
autor(king_in_black, donny_cates).
autor(batman_ano_1, frank_miller).
autor(wolverine_2024, saladin_ahmed).
autor(magik_colossus_2026, ashley_allen).
autor(sorcerer_supreme_2025, steve_orlando).
autor(fantastic_four_2025, ryan_north).

% Universos (Fundamental para tus reglas)
%dc
universo_principal(all_star_superman, no).
universo_principal(batman_ano_1, si).
universo_principal(absolute_wonderwoman, no).
universo_principal(teen_titans_2026, si).
universo_principal(green_lantern_2026, si).
universo_principal(dc_ko, si).
universo_principal(barbara_gordon_breakout, si).
universo_principal(deathstroke_the_terminator_2026, si).
universo_principal(superman_2023, si).
universo_principal(batman_deadpool_2025, no).
%marvel
universo_principal(spiderman_noir, no).
universo_principal(capitan_america_white, si).
universo_principal(what_if, no).
universo_principal(wolverine_2024, si).
universo_principal(inmortal_hulk, si).
universo_principal(magik_colossus_2026, si).
universo_principal(x_men_united, si).
universo_principal(king_in_black, si).
universo_principal(sorcerer_supreme_2025, si).
universo_principal(fantastic_four_2025, si).


% formato
%DC
formato_serie(all_star_superman, miniserie).
formato_serie(batman_ano_1, arco).
formato_serie(absolute_wonderwoman, serie_regular).
formato_serie(teen_titans_2026, serie_regular).
formato_serie(green_lantern_2026, serie_regular).
formato_serie(dc_ko, evento).
formato_serie(barbara_gordon_breakout, serie_regular).
formato_serie(deathstroke_the_terminator_2026, miniserie).
formato_serie(superman_2023, serie_regular).
formato_serie(batman_deadpool_2025, miniserie).
%Marvel
formato_serie(spiderman_noir, miniserie).
formato_serie(capitan_america_white, miniserie).
formato_serie(what_if, antologia).
formato_serie(wolverine_2024, serie_regular).
formato_serie(inmortal_hulk, serie_regular).
formato_serie(magik_colossus_2026, miniserie).
formato_serie(x_men_united, serie_regular).
formato_serie(king_in_black, evento).
formato_serie(sorcerer_supreme_2025, serie_regular).
formato_serie(fantastic_four_2025, serie_regular).

% --- 3. REGLAS LÓGICAS (L.P.O. Aplicada) ---
%Un cómic es válido en tu sistema solo si cumple todas las reglas del dominio.
comic_valido(X) :-
    comic(X),                                % Debe existir como cómic
    editorial(X, Editorial), 
    (Editorial = dc ; Editorial = marvel),   % Debe ser DC o Marvel
    anio_publicacion(X, Anio),
    Anio >= 2000,                            % Del 2000 en adelante
    universo_principal(X, si),               % Solo universo principal
    formato_serie(X,Formato),				 % tipo de serie
	(Formato = miniserie ; Formato = serie_regular ; Formato = antologia ; Formato = evento ; Formato= arco). 