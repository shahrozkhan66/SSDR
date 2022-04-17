function plotKLmode(InputDesign, eigen)
points_x = reshape(InputDesign(:,1),[25,90]);
points_y = reshape(InputDesign(:,2),[25,90]);
points_z = reshape(InputDesign(:,3),[25,90]);

eigen_x = reshape(eigen(:,1),[25,90]);
eigen_y = reshape(eigen(:,2),[25,90]);
eigen_z = reshape(eigen(:,3),[25,90]);

%-- Surface Plot
m =surf(points_x,points_y,points_z,abs(eigen_y));
m.EdgeColor = 'k';
shading interp
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
axis equal off
end
