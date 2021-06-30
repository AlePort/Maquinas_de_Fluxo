using Plots, Latexify, LaTeXStrings

e = [2.15, 3.11, 4.81, 7.06, 10, 13.1, 17.1, 22.1, 25.1, 28.4, 31.6, 34.7, 36.8, 41.7, 46.6, 51.7, 56]

b₀ = [21280, 12260, 9312, 6937, 6219, 5105, 5363, 3960, 3063, 2967, 3113, 2449, 2237, 1979, 2266, 2266, 2266]

b₁ = [1231, 973.3, 776.8, 697.9, 589.8, 572.8, 415.7, 362.1, 366, 333.3, 281.1, 302, 314, 325.3, 302, 302, 302]

scatter(e,b₀,legend=true,
 xlabel="Thickness", ylabel = "Unit pressure drop", labels = "b₀", title = "NC 2733 foam", xlim=(0,60),ylim=(0,25000))
plot!(e, b₁, label = "b₁", seriestype = :scatter)

A = [e[i]^j for i in 1:17, j in -1:0]

ê₀ = A \ b₀

b̂₀(e) = ê₀' * [e^-1,1]

ê₁ = A \ b₁

b̂₁(e) = ê₁' * [e^-1,1]

plot!(b̂₀, label = "b₀(e)")
plot!(b̂₁, label = "b₁(e)")

E = [5.12, 10, 13.2, 15.6, 20.4, 21.7, 25.3, 30.7, 37.5, 41.8, 44.9, 47.2, 50.8, 55, 59.9, 62.1]

b₂ = [5665, 2689, 2144, 2236, 1592, 1872, 1151, 1196, 1334, 947, 1076, 1060, 1093, 888.7, 817.1, 949.2]

b₃ = [256.2, 271.7, 235.9, 208.6, 171.3, 139.5, 155.8, 127.5, 93.9, 104.2, 91.3, 86.1, 79.9, 87.6, 86.7, 82.4]

scatter(E,b₂,legend=true,
 xlabel="Thickness", ylabel = "Unit pressure drop", label = "b₂", xlim=(0,70), ylim=(0,6000))
plot!(E, b₃, label = "b₃",seriestype = :scatter)

B = [E[i]^j for i in 1:16, j in -1:0]

ê₂ = B \ b₂

b̂₂(E) = ê₂' * [E^-1,1]

ê₃ = B \ b₃

b̂₃(E) = ê₃' * [E^-1,1]

plot!(b̂₂, label = "b₂(e)")
plot!(b̂₃, label = "b₃(e)")

compₐ = []
erroₐ = []
a_C = [1623.500, 433.890, 39415.000, 25798.000, 284.200, 83.501, 2177.600, 1230.200]
a_AR = [ê₀[2], ê₂[2], ê₀[1], ê₂[1], ê₁[2], ê₃[2], ê₁[1], ê₃[1]]

for i in 1:8
    append!(compₐ, abs(a_AR[i]-a_C[i]))
    append!(erroₐ, round(compₐ[i]/a_C[i]*100, digits=2))
end

NC2733_AR = []
NC2733_C = []
NC2733_erro = []
NCX1116_AR = []
NCX1116_C = []
NCX1116_erro = []

for i in 1:4
    imp = 2i - 1
    par = 2i
    append!(NC2733_AR, a_AR[imp])
    append!(NC2733_C, a_C[imp])
    append!(NC2733_erro, erroₐ[imp])
    append!(NCX1116_AR, a_AR[par])
    append!(NCX1116_C, a_C[par])
    append!(NCX1116_erro, erroₐ[par])
    
end

using DataFrames

df = DataFrame(Coeficientes=["a₀", "a₁", "a₂", "a₃"],
    NC2733_Artigo=NC2733_AR, NC2733_Experimento=NC2733_C, NC2733_Erro=NC2733_erro,
    NCX1116_Artigo=NCX1116_AR, NCX1116_Experimento=NCX1116_C, NCX1116_Erro=NCX1116_erro)


show(df, allcols=true)
print("\n\n(Erros já em porcentagem)")
display(df, )


using PyCall
import CoolProp.CoolProp

CP = pyimport("CoolProp.CoolProp")

T = 90 + 273.15
P = 100

stt = CP.State("Air", {"T":T, "P":P})
