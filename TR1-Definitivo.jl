### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ d5d8aca7-1771-4bd9-9761-11b667f894fa
using Plots, Latexify, LaTeXStrings, DataFrames, PlutoUI	

# ╔═╡ 7a45e73e-2bc0-489f-a7e1-4daa852589e1
md"# Máquinas de Fluxo - TR1
\
**Alunos:**
* Alessandro Cappellini Portugal
* Rodrigo Kenji Kuroda
* Jean Carlos Reisdorfer
* Laís Tussi
* Stella Colferai
"

# ╔═╡ c7180b99-37f6-4494-aafb-57bdec113524
html"""<p style="font-family: times; text-align: center; font-style:bold; font-size: 14.5pt"><a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a></p>This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>."""

# ╔═╡ b42465ab-12ae-4e2e-a4dd-ccf375cd69f4
md"## NC 2733"

# ╔═╡ 67277e58-4e39-4ced-9135-ce059ed3fe51
begin
	e = [2.15, 3.11, 4.81, 7.06, 10, 13.1, 17.1, 22.1, 25.1, 28.4, 31.6, 34.7, 36.8, 41.7, 46.6, 51.7, 56]
	b₀ = [21280, 12260, 9312, 6937, 6219, 5105, 5363, 3960, 3063, 2967, 3113, 2449, 2237, 1979, 2266, 2266, 2266]
	b₁ = [1231, 973.3, 776.8, 697.9, 589.8, 572.8, 415.7, 362.1, 366, 333.3, 281.1, 302, 314, 325.3, 302, 302, 302]
end

# ╔═╡ 6de97699-ca2f-4d84-9c6c-0d1cf2fb9781
begin
	scatter(e,b₀,legend=true, xlabel="Thickness [m]", ylabel = "Unit pressure drop [Pa/m]", labels = "b₀", title = "NC 2733", xlim=(0,60),ylim=(0,25000))
	plot!(e, b₁, label = "b₁", seriestype = :scatter)
end

# ╔═╡ d9760d43-f85c-4574-b896-f098e52a5e9f
md"### Equação dos coeficientes e matriz A:

$b_{0}(e) = \frac{a_{0}}{e} + a_{1} = a_{0}\cdot e^{-1} + a_{1} = \begin{bmatrix} e^{-1} & 1 \end{bmatrix} \cdot \begin{bmatrix} a_{0}\\a_{1} \end{bmatrix}$

$A = \begin{bmatrix} e_{0} & 1 \\ e_{1} & 1 \\ \vdots & \vdots \\ e_{16} & 1 \end{bmatrix}$"

# ╔═╡ 0e89da5e-0028-4294-abca-62aa25435d4e
begin
	A = [e[i]^j for i in 1:17, j in -1:0]
	ê₀ = A \ b₀
	b̂₀(e) = ê₀' * [e^-1,1]
	ê₁ = A \ b₁
	b̂₁(e) = ê₁' * [e^-1,1]
	Print(ê₀, ê₁)
end

# ╔═╡ 183dfa02-3e9b-4d37-af9c-e14749d7bbed
begin
	plot!(b̂₀, label = "b₀(e)")
	plot!(b̂₁, label = "b₁(e)")
end

# ╔═╡ 7ca1454b-6b82-435f-8495-378634a92ddd
md"## NCX1116"

# ╔═╡ ce7b5b46-ce40-4fde-b919-4e7aa463621b
begin
	E = [5.12, 10, 13.2, 15.6, 20.4, 21.7, 25.3, 30.7, 37.5, 41.8, 44.9, 47.2, 50.8, 55, 59.9, 62.1]
	b₂ = [5665, 2689, 2144, 2236, 1592, 1872, 1151, 1196, 1334, 947, 1076, 1060, 1093, 888.7, 817.1, 949.2]
	b₃ = [256.2, 271.7, 235.9, 208.6, 171.3, 139.5, 155.8, 127.5, 93.9, 104.2, 91.3, 86.1, 79.9, 87.6, 86.7, 82.4]
end

# ╔═╡ 2a30f4cd-65cb-4fb6-bc45-7c3999e74ce0
begin
	scatter(E,b₂,legend=true, xlabel="Thickness [m]", ylabel = "Unit pressure drop [Pa/m]", label = "b₂", title = "NCX1116", xlim=(0,70), ylim=(0,6000))
	plot!(E, b₃, label = "b₃",seriestype = :scatter)
end

# ╔═╡ 63b5568d-8a7c-456d-912e-bf0f41821a27
md"### Equação dos coeficientes e matriz B:

$b_{2}(e) = \frac{a_{2}}{e} + a_{3} = a_{2}\cdot e^{-1} + a_{3} = \begin{bmatrix} e^{-1} & 1 \end{bmatrix} \cdot \begin{bmatrix} a_{2}\\a_{3} \end{bmatrix}$

$B = \begin{bmatrix} e_{0} & 1 \\ e_{1} & 1 \\ \vdots & \vdots \\ e_{15} & 1 \end{bmatrix}$"

# ╔═╡ 4c940207-3f1d-431b-9c01-52f05ab4e7d0
begin
	B = [E[i]^j for i in 1:16, j in -1:0]
	ê₂ = B \ b₂
	b̂₂(E) = ê₂' * [E^-1,1]
	ê₃ = B \ b₃
	b̂₃(E) = ê₃' * [E^-1,1]
	Print(ê₂, ê₃)
end

# ╔═╡ 80098407-d77f-4282-8776-93bb395e23ca
begin
	plot!(b̂₂, label = "b₂(e)")
	plot!(b̂₃, label = "b₃(e)")
end

# ╔═╡ fb25f078-e1fd-46e1-b231-5404f57edc15
begin
	compₐ1 = []
	erroₐ1 = []
	a_C1 = [1623.500, 39415.000, 284.200, 2177.600]
	a_AR1 = [ê₀[2], ê₀[1], ê₁[2], ê₁[1]]
	compₐ2 = []
	erroₐ2 = []
	a_C2 = [433.890, 25798.000, 83.501, 1230.200]
	a_AR2 = [ê₂[2], ê₂[1], ê₃[2], ê₃[1]]
	
	for i in 1:4
		append!(compₐ1, abs(a_AR1[i]-a_C1[i]))
		append!(erroₐ1, round(compₐ1[i]/a_C1[i]*100, digits=2))
		append!(compₐ2, abs(a_AR2[i]-a_C2[i]))
		append!(erroₐ2, round(compₐ2[i]/a_C2[i]*100, digits=2))
	end
	
	df1 = DataFrame(a=["a₀", "a₁", "a₂", "a₃"], artigo1=a_C1, experimento1=a_AR1, erro1=erroₐ1)
		
	rename!(df1, ["NC 2733", "Artigo", "Experimento", "Erro [%]"])
	
	df2 = DataFrame(a=["a₀", "a₁", "a₂", "a₃"], artigo2=a_C2, experimento2=a_AR2, erro2=erroₐ2)
	
	rename!(df2, ["NCX1116", "Artigo", "Experimento", "Erro [%]"])
	
	md"## Tabelas dos coeficientes e respectivas equações:"
end

# ╔═╡ c3eda44f-4bf3-4e6b-b9da-a730545118f7
df1

# ╔═╡ 18d0707c-e035-4c1e-8664-7a077648a9d3
L"$$
b_0(e) = 1624,43 + \frac{39375,80}{e}
$$
$$
b_1(e) = 284,31 + \frac{2174,91}{e}
$$"

# ╔═╡ fa429a6c-e740-4317-ba60-59a5b0d99b87
df2

# ╔═╡ cf4e0ac7-15d9-402d-9c40-a5eb600449f1
L"$$
b_2(e) = 434,34 + \frac{25760,50}{e}
$$
$$
b_3(e) = 83,50 + \frac{1228,77}{e}
$$"

# ╔═╡ Cell order:
# ╟─7a45e73e-2bc0-489f-a7e1-4daa852589e1
# ╟─c7180b99-37f6-4494-aafb-57bdec113524
# ╟─b42465ab-12ae-4e2e-a4dd-ccf375cd69f4
# ╠═d5d8aca7-1771-4bd9-9761-11b667f894fa
# ╠═67277e58-4e39-4ced-9135-ce059ed3fe51
# ╠═6de97699-ca2f-4d84-9c6c-0d1cf2fb9781
# ╟─d9760d43-f85c-4574-b896-f098e52a5e9f
# ╠═0e89da5e-0028-4294-abca-62aa25435d4e
# ╠═183dfa02-3e9b-4d37-af9c-e14749d7bbed
# ╟─7ca1454b-6b82-435f-8495-378634a92ddd
# ╠═ce7b5b46-ce40-4fde-b919-4e7aa463621b
# ╠═2a30f4cd-65cb-4fb6-bc45-7c3999e74ce0
# ╟─63b5568d-8a7c-456d-912e-bf0f41821a27
# ╠═4c940207-3f1d-431b-9c01-52f05ab4e7d0
# ╠═80098407-d77f-4282-8776-93bb395e23ca
# ╟─fb25f078-e1fd-46e1-b231-5404f57edc15
# ╟─c3eda44f-4bf3-4e6b-b9da-a730545118f7
# ╟─18d0707c-e035-4c1e-8664-7a077648a9d3
# ╟─fa429a6c-e740-4317-ba60-59a5b0d99b87
# ╟─cf4e0ac7-15d9-402d-9c40-a5eb600449f1
